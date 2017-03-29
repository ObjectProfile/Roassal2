"
A PyProcessorTest is a test class for testing the behavior of PyProcessor
"
Class {
	#name : #PyProcessorTest,
	#superclass : #TestCase,
	#instVars : [
		'p'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Tests'
}

{ #category : #sources }
PyProcessorTest >> codeOOP [
^
'class Foo(object):
    def getValue(self):
        return self.fibonacci(10)

    def fibonacci(self, n):
        if n < 2:
            return n
        else:
            return self.fibonacci(n - 1) + self.fibonacci(n - 2)
    
class Bar(Foo):
    def foo(self):
        return 42

if __name__ == ''__main__'':
    print(''Value = %d\n'' % (Foo().getValue()))
'
]

{ #category : #sources }
PyProcessorTest >> file01 [
	^ '
import random

guesses_made = 0

name = raw_input(''Hello! What is your name?\n'')

number = random.randint(1, 20)
print ''Well, {0}, I am thinking of a number between 1 and 20.''.format(name)

while guesses_made < 6:

    guess = int(raw_input(''Take a guess: ''))

    guesses_made += 1

    if guess < number:
        print ''Your guess is too low.''

    if guess > number:
        print ''Your guess is too high.''

    if guess == number:
        break

if guess == number:
    print ''Good job, {0}! You guessed my number in {1} guesses!''.format(name, guesses_made)
else:
    print ''Nope. The number I was thinking of was {0}''.format(number)
	'.
]

{ #category : #sources }
PyProcessorTest >> file02 [

	^ '# Author: Andreas Christian Mueller <t3kcit@gmail.com>
#
# (c) 2012
# Modified by: Paul Nechifor <paul@nechifor.net>
#
# License: MIT

from __future__ import division

import warnings
from random import Random
import os
import re
import sys
import colorsys
import numpy as np
from operator import itemgetter

from PIL import Image
from PIL import ImageColor
from PIL import ImageDraw
from PIL import ImageFont

from .query_integral_image import query_integral_image
from .tokenization import unigrams_and_bigrams, process_tokens

item1 = itemgetter(1)

FONT_PATH = os.environ.get("FONT_PATH", os.path.join(os.path.dirname(__file__),
                                                     "DroidSansMono.ttf"))
STOPWORDS = set([x.strip() for x in open(
    os.path.join(os.path.dirname(__file__), ''stopwords'')).read().split(''\n'')])


class IntegralOccupancyMap(object):
    def __init__(self, height, width, mask):
        self.height = height
        self.width = width
        if mask is not None:
            # the order of the cumsum''s is important for speed ?!
            self.integral = np.cumsum(np.cumsum(255 * mask, axis=1),
                                      axis=0).astype(np.uint32)
        else:
            self.integral = np.zeros((height, width), dtype=np.uint32)

    def sample_position(self, size_x, size_y, random_state):
        return query_integral_image(self.integral, size_x, size_y,
                                    random_state)

    def update(self, img_array, pos_x, pos_y):
        partial_integral = np.cumsum(np.cumsum(img_array[pos_x:, pos_y:],
                                               axis=1), axis=0)
        # paste recomputed part into old image
        # if x or y is zero it is a bit annoying
        if pos_x > 0:
            if pos_y > 0:
                partial_integral += (self.integral[pos_x - 1, pos_y:]
                                     - self.integral[pos_x - 1, pos_y - 1])
            else:
                partial_integral += self.integral[pos_x - 1, pos_y:]
        if pos_y > 0:
            partial_integral += self.integral[pos_x:, pos_y - 1][:, np.newaxis]

        self.integral[pos_x:, pos_y:] = partial_integral


def random_color_func(word=None, font_size=None, position=None,
                      orientation=None, font_path=None, random_state=None):
    """Random hue color generation.

    Default coloring method. This just picks a random hue with value 80% and
    lumination 50%.

    Parameters
    ----------
    word, font_size, position, orientation  : ignored.

    random_state : random.Random object or None, (default=None)
        If a random object is given, this is used for generating random
        numbers.

    """
    if random_state is None:
        random_state = Random()
    return "hsl(%d, 80%%, 50%%)" % random_state.randint(0, 255)


class colormap_color_func(object):
    """Color func created from matplotlib colormap.

    Parameters
    ----------
    colormap : string or matplotlib colormap
        Colormap to sample from

    Example
    -------
    >>> WordCloud(color_func=colormap_color_func("magma"))

    """
    def __init__(self, colormap):
        import matplotlib.pyplot as plt
        self.colormap = plt.cm.get_cmap(colormap)

    def __call__(self, word, font_size, position, orientation,
                 random_state=None, **kwargs):
        if random_state is None:
            random_state = Random()
        r, g, b, _ = 255 * np.array(self.colormap(random_state.uniform(0, 1)))
        return "rgb({:.0f}, {:.0f}, {:.0f})".format(r, g, b)


def get_single_color_func(color):
    """Create a color function which returns a single hue and saturation with.
    different values (HSV). Accepted values are color strings as usable by
    PIL/Pillow.

    >>> color_func1 = get_single_color_func(''deepskyblue'')
    >>> color_func2 = get_single_color_func(''#00b4d2'')
    """
    old_r, old_g, old_b = ImageColor.getrgb(color)
    rgb_max = 255.
    h, s, v = colorsys.rgb_to_hsv(old_r / rgb_max, old_g / rgb_max,
                                  old_b / rgb_max)

    def single_color_func(word=None, font_size=None, position=None,
                          orientation=None, font_path=None, random_state=None):
        """Random color generation.

        Additional coloring method. It picks a random value with hue and
        saturation based on the color given to the generating function.

        Parameters
        ----------
        word, font_size, position, orientation  : ignored.

        random_state : random.Random object or None, (default=None)
          If a random object is given, this is used for generating random
          numbers.

        """
        if random_state is None:
            random_state = Random()
        r, g, b = colorsys.hsv_to_rgb(h, s, random_state.uniform(0.2, 1))
        return ''rgb({:.0f}, {:.0f}, {:.0f})''.format(r * rgb_max, g * rgb_max,
                                                    b * rgb_max)
    return single_color_func


class WordCloud(object):
    """Word cloud object for generating and drawing.

    Parameters
    ----------
    font_path : string
        Font path to the font that will be used (OTF or TTF).
        Defaults to DroidSansMono path on a Linux machine. If you are on
        another OS or don''t have this font, you need to adjust this path.

    width : int (default=400)
        Width of the canvas.

    height : int (default=200)
        Height of the canvas.

    prefer_horizontal : float (default=0.90)
        The ratio of times to try horizontal fitting as opposed to vertical.

    mask : nd-array or None (default=None)
        If not None, gives a binary mask on where to draw words. If mask is not
        None, width and height will be ignored and the shape of mask will be
        used instead. All white (#FF or #FFFFFF) entries will be considerd
        "masked out" while other entries will be free to draw on. [This
        changed in the most recent version!]

    scale : float (default=1)
        Scaling between computation and drawing. For large word-cloud images,
        using scale instead of larger canvas size is significantly faster, but
        might lead to a coarser fit for the words.

    min_font_size : int (default=4)
        Smallest font size to use. Will stop when there is no more room in this
        size.

    font_step : int (default=1)
        Step size for the font. font_step > 1 might speed up computation but
        give a worse fit.

    max_words : number (default=200)
        The maximum number of words.

    stopwords : set of strings
        The words that will be eliminated.

    background_color : color value (default="black")
        Background color for the word cloud image.

    max_font_size : int or None (default=None)
        Maximum font size for the largest word. If None, height of the image is
        used.

    mode : string (default="RGB")
        Transparent background will be generated when mode is "RGBA" and
        background_color is None.

    relative_scaling : float (default=.5)
        Importance of relative word frequencies for font-size.  With
        relative_scaling=0, only word-ranks are considered.  With
        relative_scaling=1, a word that is twice as frequent will have twice
        the size.  If you want to consider the word frequencies and not only
        their rank, relative_scaling around .5 often looks good.

        .. versionchanged: 2.0
            Default is now 0.5.

    color_func : callable, default=None
        Callable with parameters word, font_size, position, orientation,
        font_path, random_state that returns a PIL color for each word.
        Overwrites "colormap".
        See colormap for specifying a matplotlib colormap instead.

    regexp : string or None (optional)
        Regular expression to split the input text into tokens in process_text.
        If None is specified, ``r"\w[\w'']+"`` is used.

    collocations : bool, default=True
        Whether to include collocations (bigrams) of two words.

        .. versionadded: 2.0

    colormap : string or matplotlib colormap, default="viridis"
        Matplotlib colormap to randomly draw colors from for each word.
        Ignored if "color_func" is specified.

        .. versionadded: 2.0

    Attributes
    ----------
    ``words_`` : dict of string to float
        Word tokens with associated frequency.

        .. versionchanged: 2.0
            ``words_`` is now a dictionary

    ``layout_`` : list of tuples (string, int, (int, int), int, color))
        Encodes the fitted word cloud. Encodes for each word the string, font
        size, position, orientation and color.

    Notes
    -----
    Larger canvases with make the code significantly slower. If you need a
    large word cloud, try a lower canvas size, and set the scale parameter.

    The algorithm might give more weight to the ranking of the words
    than their actual frequencies, depending on the ``max_font_size`` and the
    scaling heuristic.
    """

    def __init__(self, font_path=None, width=400, height=200, margin=2,
                 ranks_only=None, prefer_horizontal=.9, mask=None, scale=1,
                 color_func=None, max_words=200, min_font_size=4,
                 stopwords=None, random_state=None, background_color=''black'',
                 max_font_size=None, font_step=1, mode="RGB",
                 relative_scaling=.5, regexp=None, collocations=True,
                 colormap=None):
        if font_path is None:
            font_path = FONT_PATH
        if color_func is None and colormap is None:
            # we need a color map
            import matplotlib
            version = matplotlib.__version__
            if version[0] < "2" and version[2] < "5":
                colormap = "hsv"
            else:
                colormap = "viridis"
        self.colormap = colormap
        self.collocations = collocations
        self.font_path = font_path
        self.width = width
        self.height = height
        self.margin = margin
        self.prefer_horizontal = prefer_horizontal
        self.mask = mask
        self.scale = scale
        self.color_func = color_func or colormap_color_func(colormap)
        self.max_words = max_words
        self.stopwords = stopwords if stopwords is not None else STOPWORDS
        self.min_font_size = min_font_size
        self.font_step = font_step
        self.regexp = regexp
        if isinstance(random_state, int):
            random_state = Random(random_state)
        self.random_state = random_state
        self.background_color = background_color
        self.max_font_size = max_font_size
        self.mode = mode
        if relative_scaling < 0 or relative_scaling > 1:
            raise ValueError("relative_scaling needs to be "
                             "between 0 and 1, got %f." % relative_scaling)
        self.relative_scaling = relative_scaling
        if ranks_only is not None:
            warnings.warn("ranks_only is deprecated and will be removed as"
                          " it had no effect. Look into relative_scaling.",
                          DeprecationWarning)

    def fit_words(self, frequencies):
        """Create a word_cloud from words and frequencies.

        Alias to generate_from_frequencies.

        Parameters
        ----------
        frequencies : array of tuples
            A tuple contains the word and its frequency.

        Returns
        -------
        self
        """
        return self.generate_from_frequencies(frequencies)

    def generate_from_frequencies(self, frequencies, max_font_size=None):
        """Create a word_cloud from words and frequencies.

        Parameters
        ----------
        frequencies : dict from string to float
            A contains words and associated frequency.

        max_font_size : int
            Use this font-size instead of self.max_font_size

        Returns
        -------
        self

        """
        # make sure frequencies are sorted and normalized
        frequencies = sorted(frequencies.items(), key=item1, reverse=True)
        frequencies = frequencies[:self.max_words]
        # largest entry will be 1
        max_frequency = float(frequencies[0][1])

        frequencies = [(word, freq / max_frequency)
                       for word, freq in frequencies]

        if self.random_state is not None:
            random_state = self.random_state
        else:
            random_state = Random()

        if len(frequencies) <= 0:
            print("We need at least 1 word to plot a word cloud, got %d."
                  % len(frequencies))

        if self.mask is not None:
            mask = self.mask
            width = mask.shape[1]
            height = mask.shape[0]
            if mask.dtype.kind == ''f'':
                warnings.warn("mask image should be unsigned byte between 0"
                              " and 255. Got a float array")
            if mask.ndim == 2:
                boolean_mask = mask == 255
            elif mask.ndim == 3:
                # if all channels are white, mask out
                boolean_mask = np.all(mask[:, :, :3] == 255, axis=-1)
            else:
                raise ValueError("Got mask of invalid shape: %s"
                                 % str(mask.shape))
        else:
            boolean_mask = None
            height, width = self.height, self.width
        occupancy = IntegralOccupancyMap(height, width, boolean_mask)

        # create image
        img_grey = Image.new("L", (width, height))
        draw = ImageDraw.Draw(img_grey)
        img_array = np.asarray(img_grey)
        font_sizes, positions, orientations, colors = [], [], [], []

        last_freq = 1.

        if max_font_size is None:
            # if not provided use default font_size
            max_font_size = self.max_font_size

        if max_font_size is None:
            # figure out a good font size by trying to draw with
            # just the first two words
            if len(frequencies) == 1:
                # we only have one word. We make it big!
                font_size = self.height
            else:
                self.generate_from_frequencies(dict(frequencies[:2]),
                                               max_font_size=self.height)
                # find font sizes
                sizes = [x[1] for x in self.layout_]
                font_size = 2 * sizes[0] * sizes[1] / (sizes[0] + sizes[1])
        else:
            font_size = max_font_size

        # we set self.words_ here because we called generate_from_frequencies
        # above... hurray for good design?
        self.words_ = dict(frequencies)

        # start drawing grey image
        for word, freq in frequencies:
            # select the font size
            rs = self.relative_scaling
            if rs != 0:
                font_size = int(round((rs * (freq / float(last_freq))
                                       + (1 - rs)) * font_size))
            if random_state.random() < self.prefer_horizontal:
                orientation = None
            else:
                orientation = Image.ROTATE_90
            tried_other_orientation = False
            while True:
                # try to find a position
                font = ImageFont.truetype(self.font_path, font_size)
                # transpose font optionally
                transposed_font = ImageFont.TransposedFont(
                    font, orientation=orientation)
                # get size of resulting text
                box_size = draw.textsize(word, font=transposed_font)
                # find possible places using integral image:
                result = occupancy.sample_position(box_size[1] + self.margin,
                                                   box_size[0] + self.margin,
                                                   random_state)
                if result is not None or font_size < self.min_font_size:
                    # either we found a place or font-size went too small
                    break
                # if we didn''t find a place, make font smaller
                if tried_other_orientation is False:
                    orientation = (Image.ROTATE_90 if orientation is None else
                                   Image.ROTATE_90)
                    tried_other_orientation = True
                else:
                    font_size -= self.font_step
                    orientation = None

            if font_size < self.min_font_size:
                # we were unable to draw any more
                break

            x, y = np.array(result) + self.margin // 2
            # actually draw the text
            draw.text((y, x), word, fill="white", font=transposed_font)
            positions.append((x, y))
            orientations.append(orientation)
            font_sizes.append(font_size)
            colors.append(self.color_func(word, font_size=font_size,
                                          position=(x, y),
                                          orientation=orientation,
                                          random_state=random_state,
                                          font_path=self.font_path))
            # recompute integral image
            if self.mask is None:
                img_array = np.asarray(img_grey)
            else:
                img_array = np.asarray(img_grey) + boolean_mask
            # recompute bottom right
            # the order of the cumsum''s is important for speed ?!
            occupancy.update(img_array, x, y)
            last_freq = freq

        self.layout_ = list(zip(frequencies, font_sizes, positions,
                                orientations, colors))
        return self

    def process_text(self, text):
        """Splits a long text into words, eliminates the stopwords.

        Parameters
        ----------
        text : string
            The text to be processed.

        Returns
        -------
        words : dict (string, int)
            Word tokens with associated frequency.

        ..versionchanged:: 1.2.2
            Changed return type from list of tuples to dict.

        Notes
        -----
        There are better ways to do word tokenization, but I don''t want to
        include all those things.
        """

        stopwords = set(map(str.lower, self.stopwords))

        flags = (re.UNICODE if sys.version < ''3'' and type(text) is unicode
                 else 0)
        regexp = self.regexp if self.regexp is not None else r"\w[\w'']+"

        words = re.findall(regexp, text, flags)
        # remove stopwords
        words = [word for word in words if word.lower() not in stopwords]
        # remove ''s
        words = [word[:-2] if word.lower().endswith("''s") else word
                 for word in words]
        # remove numbers
        words = [word for word in words if not word.isdigit()]

        if self.collocations:
            word_counts = unigrams_and_bigrams(words)
        else:
            word_counts, _ = process_tokens(words)

        return word_counts

    def generate_from_text(self, text):
        """Generate wordcloud from text.

        Calls process_text and generate_from_frequencies.

        ..versionchanged:: 1.2.2
            Argument of generate_from_frequencies() is not return of
            process_text() any more.

        Returns
        -------
        self
        """
        words = self.process_text(text)
        self.generate_from_frequencies(words)
        return self

    def generate(self, text):
        """Generate wordcloud from text.

        Alias to generate_from_text.

        Calls process_text and generate_from_frequencies.

        Returns
        -------
        self
        """
        return self.generate_from_text(text)

    def _check_generated(self):
        """Check if ``layout_`` was computed, otherwise raise error."""
        if not hasattr(self, "layout_"):
            raise ValueError("WordCloud has not been calculated, call generate"
                             " first.")

    def to_image(self):
        self._check_generated()
        if self.mask is not None:
            width = self.mask.shape[1]
            height = self.mask.shape[0]
        else:
            height, width = self.height, self.width

        img = Image.new(self.mode, (int(width * self.scale),
                                    int(height * self.scale)),
                        self.background_color)
        draw = ImageDraw.Draw(img)
        for (word, count), font_size, position, orientation, color in self.layout_:
            font = ImageFont.truetype(self.font_path,
                                      int(font_size * self.scale))
            transposed_font = ImageFont.TransposedFont(
                font, orientation=orientation)
            pos = (int(position[1] * self.scale),
                   int(position[0] * self.scale))
            draw.text(pos, word, fill=color, font=transposed_font)
        return img

    def recolor(self, random_state=None, color_func=None, colormap=None):
        """Recolor existing layout.

        Applying a new coloring is much faster than generating the whole
        wordcloud.

        Parameters
        ----------
        random_state : RandomState, int, or None, default=None
            If not None, a fixed random state is used. If an int is given, this
            is used as seed for a random.Random state.

        color_func : function or None, default=None
            Function to generate new color from word count, font size, position
            and orientation.  If None, self.color_func is used.

        colormap : string or matplotlib colormap, default=None
            Use this colormap to generate new colors. Ignored if color_func
            is specified. If None, self.color_func (or self.color_map) is used.

        Returns
        -------
        self
        """
        if isinstance(random_state, int):
            random_state = Random(random_state)
        self._check_generated()

        if color_func is None:
            if colormap is None:
                color_func = self.color_func
            else:
                color_func = colormap_color_func(colormap)
        self.layout_ = [(word_freq, font_size, position, orientation,
                         color_func(word=word_freq[0], font_size=font_size,
                                    position=position, orientation=orientation,
                                    random_state=random_state,
                                    font_path=self.font_path))
                        for word_freq, font_size, position, orientation, _
                        in self.layout_]
        return self

    def to_file(self, filename):
        """Export to image file.

        Parameters
        ----------
        filename : string
            Location to write to.

        Returns
        -------
        self
        """

        img = self.to_image()
        img.save(filename)
        return self

    def to_array(self):
        """Convert to numpy array.

        Returns
        -------
        image : nd-array size (width, height, 3)
            Word cloud image as numpy matrix.
        """
        return np.array(self.to_image())

    def __array__(self):
        """Convert to numpy array.

        Returns
        -------
        image : nd-array size (width, height, 3)
            Word cloud image as numpy matrix.
        """
        return self.to_array()

    def to_html(self):
        raise NotImplementedError("FIXME!!!")
'
]

{ #category : #sources }
PyProcessorTest >> file03 [
"__init__.py"
	^ '
from .wordcloud import WordCloud, STOPWORDS, random_color_func, get_single_color_func
from .color_from_image import ImageColorGenerator

__all__ = [''WordCloud'', ''STOPWORDS'', ''random_color_func'', ''get_single_color_func'', ''ImageColorGenerator'']

'.
]

{ #category : #sources }
PyProcessorTest >> file04 [
"color_from_image.py"
	^ '
import numpy as np
from PIL import ImageFont


class ImageColorGenerator(object):
    """Color generator based on a color image.

    Generates colors based on an RGB image. A word will be colored using
    the mean color of the enclosing rectangle in the color image.

    After construction, the object acts as a callable that can be passed as
    color_func to the word cloud constructor or to the recolor method.

    Parameters
    ----------
    image : nd-array, shape (height, width, 3)
        Image to use to generate word colors. Alpha channels are ignored.
        This should be the same size as the canvas. for the wordcloud.
    """
    # returns the average color of the image in that region
    def __init__(self, image):
        if image.ndim not in [2, 3]:
            raise ValueError("ImageColorGenerator needs an image with ndim 2 or"
                             " 3, got %d" % image.ndim)
        if image.ndim == 3 and image.shape[2] not in [3, 4]:
            raise ValueError("A color image needs to have 3 or 4 channels, got %d"
                             % image.shape[2])
        self.image = image

    def __call__(self, word, font_size, font_path, position, orientation, **kwargs):
        """Generate a color for a given word using a fixed image."""
        # get the font to get the box size
        font = ImageFont.truetype(font_path, font_size)
        transposed_font = ImageFont.TransposedFont(font,
                                                   orientation=orientation)
        # get size of resulting text
        box_size = transposed_font.getsize(word)
        x = position[0]
        y = position[1]
        # cut out patch under word box
        patch = self.image[x:x + box_size[0], y:y + box_size[1]]
        if patch.ndim == 3:
            # drop alpha channel if any
            patch = patch[:, :, :3]
        if patch.ndim == 2:
            raise NotImplementedError("Gray-scale images TODO")
        color = np.mean(patch.reshape(-1, 3), axis=0)
        return "rgb(%d, %d, %d)" % tuple(color)

'.
]

{ #category : #sources }
PyProcessorTest >> file05 [
"tokenization.py"
	^ '
from itertools import tee
from operator import itemgetter
from collections import defaultdict
from math import log


def l(k, n, x):
    # dunning''s likelihood ratio with notation from
    # http://nlp.stanford.edu/fsnlp/promo/colloc.pdf
    return log(max(x, 1e-10)) * k + log(max(1 - x, 1e-10)) * (n - k)


def score(count_bigram, count1, count2, n_words):
    """Collocation score"""
    N = n_words
    c12 = count_bigram
    c1 = count1
    c2 = count2
    p = c2 / N
    p1 = c12 / c1
    p2 = (c2 - c12) / (N - c1)
    score = (l(c12, c1, p) + l(c2 - c12, N - c1, p)
             - l(c12, c1, p1) - l(c2 - c12, N - c1, p2))
    return -2 * score


def pairwise(iterable):
    # from itertool recipies
    # is -> (s0,s1), (s1,s2), (s2, s3), ...
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


def unigrams_and_bigrams(words):
    n_words = len(words)
    # make tuples of two words following each other
    bigrams = list(pairwise(words))
    counts_unigrams = defaultdict(int)
    counts_bigrams = defaultdict(int)
    counts_unigrams, standard_form = process_tokens(words)
    counts_bigrams, standard_form_bigrams = process_tokens(
        [" ".join(bigram) for bigram in bigrams])
    # create a copy of counts_unigram so the score computation is not changed
    counts = counts_unigrams.copy()

    # decount words inside bigrams
    for bigram_string, count in counts_bigrams.items():
        bigram = tuple(bigram_string.split(" "))
        # collocation detection (30 is arbitrary):
        word1 = standard_form[bigram[0].lower()]
        word2 = standard_form[bigram[1].lower()]

        if score(count, counts[word1], counts[word2], n_words) > 30:
            counts_unigrams[word1] -= counts_bigrams[bigram_string]
            counts_unigrams[word2] -= counts_bigrams[bigram_string]
        # add joined bigram into unigrams
        counts_unigrams[bigram_string] = counts_bigrams[bigram_string]
    return counts_unigrams


def process_tokens(words):
    """Normalize cases and remove plurals.

    Each word is represented by the most common case.
    If a word appears with an "s" on the end and without an "s" on the end,
    the version with "s" is assumed to be a plural and merged with the
    version without "s".

    Parameters
    ----------
    words : iterable of strings
        Words to count.

    Returns
    -------
    counts : dict from string to int
        Counts for each unique word, with cases represented by the most common
        case, and plurals removed.

    standard_forms : dict from string to string
        For each lower-case word the standard capitalization.
    """
    # words can be either a list of unigrams or bigrams
    # d is a dict of dicts.
    # Keys of d are word.lower(). Values are dicts
    # counting frequency of each capitalization
    d = defaultdict(dict)
    for word in words:
        word_lower = word.lower()
        # get dict of cases for word_lower
        case_dict = d[word_lower]
        # increase this case
        case_dict[word] = case_dict.get(word, 0) + 1

    # merge plurals into the singular count (simple cases only)
    merged_plurals = {}
    for key in list(d.keys()):
        if key.endswith(''s''):
            key_singular = key[:-1]
            if key_singular in d:
                dict_plural = d[key]
                dict_singular = d[key_singular]
                for word, count in dict_plural.items():
                    singular = word[:-1]
                    dict_singular[singular] = (dict_singular.get(singular, 0)
                                               + count)
                merged_plurals[key] = key_singular
                del d[key]
    fused_cases = {}
    standard_cases = {}
    item1 = itemgetter(1)
    for word_lower, case_dict in d.items():
        # Get the most popular case.
        first = max(case_dict.items(), key=item1)[0]
        fused_cases[first] = sum(case_dict.values())
        standard_cases[word_lower] = first
    # add plurals to fused cases:
    for plural, singular in merged_plurals.items():
        standard_cases[plural] = standard_cases[singular.lower()]
    return fused_cases, standard_cases

'.
]

{ #category : #sources }
PyProcessorTest >> file06 [
"wordcloud_cli.py"
	^ '
#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""Command-line tool to generate word clouds
Usage::
    $ cat word.txt | wordcloud_cli.py

    $ wordcloud_cli.py --text=words.txt --stopwords=stopwords.txt
"""
import argparse
import wordcloud as wc
import numpy as np
import sys
from PIL import Image

def main(args):
    wordcloud = wc.WordCloud(stopwords=args.stopwords, mask=args.mask,
        width=args.width, height=args.height, font_path=args.font_path,
        margin=args.margin, relative_scaling=args.relative_scaling,
        color_func=args.color_func, background_color=args.background_color).generate(args.text)
    image = wordcloud.to_image()

    with args.imagefile:
        out = args.imagefile if sys.version < ''3'' else args.imagefile.buffer
        image.save(out, format=''png'')

def parse_args(arguments):
    prog = ''python wordcloud_cli.py''
    description = (''A simple command line interface for wordcloud module.'')
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument(''--text'', metavar=''file'', type=argparse.FileType(), default=''-'',
        help=''specify file of words to build the word cloud (default: stdin)'')
    parser.add_argument(''--stopwords'', metavar=''file'', type=argparse.FileType(),
        help=''specify file of stopwords (containing one word per line) to remove from the given text after parsing'')
    parser.add_argument(''--imagefile'', metavar=''file'', type=argparse.FileType(''w''), default=''-'',
        help=''file the completed PNG image should be written to (default: stdout)'')
    parser.add_argument(''--fontfile'', metavar=''path'', dest=''font_path'',
        help=''path to font file you wish to use (default: DroidSansMono)'')
    parser.add_argument(''--mask'', metavar=''file'', type=argparse.FileType(),
        help=''mask to use for the image form'')
    parser.add_argument(''--colormask'', metavar=''file'', type=argparse.FileType(),
        help=''color mask to use for image coloring'')
    parser.add_argument(''--relative_scaling'', type=float, default=0,
        metavar=''rs'', help='' scaling of words by frequency (0 - 1)'')
    parser.add_argument(''--margin'', type=int, default=2,
        metavar=''width'', help=''spacing to leave around words'')
    parser.add_argument(''--width'', type=int, default=400,
        metavar=''width'', help=''define output image width'')
    parser.add_argument(''--height'', type=int, default=200,
        metavar=''height'', help=''define output image height'')
    parser.add_argument(''--color'', metavar=''color'',
        help=''use given color as coloring for the image - accepts any value from PIL.ImageColor.getcolor'')
    parser.add_argument(''--background'', metavar=''color'', default=''black'', type=str, dest=''background_color'',
        help=''use given color as background color for the image - accepts any value from PIL.ImageColor.getcolor'')
    args = parser.parse_args(arguments)

    if args.colormask and args.color:
        raise ValueError(''specify either a color mask or a color function'')

    with args.text:
        args.text = args.text.read()

    if args.stopwords:
        with args.stopwords:
            args.stopwords = set(map(str.strip, args.stopwords.readlines()))

    if args.mask:
        args.mask = np.array(Image.open(args.mask))

    color_func = wc.random_color_func
    if args.colormask:
        image = np.array(Image.open(args.colormask))
        color_func = wc.ImageColorGenerator(image)

    if args.color:
        color_func = wc.get_single_color_func(args.color)

    args.color_func = color_func
    return args

if __name__ == ''__main__'':
    main(parse_args(sys.argv[1:]))

'
]

{ #category : #initialization }
PyProcessorTest >> setUp [
	p := PyProcessor new.
]

{ #category : #tests }
PyProcessorTest >> testBasic [
	| f |
	self assert: p numberOfFiles equals: 0.
	p processFileAsString: self file01 named: 'foo.py'.
	self assert: p numberOfFiles equals: 1.

	f := p files anyOne.
	self assert: f loc equals: self file01 lines size.
	self assert: f importedFilenames equals: #('random').
	self assert: f baseFilenameWithoutExtension equals: 'foo'.
	self assert: f baseFilename equals: 'foo.py'.
]

{ #category : #tests }
PyProcessorTest >> testBasic02 [
	| f |
	self assert: p numberOfFiles equals: 0.
	p processFileAsString: self file02 named: 'wordcloud.py'.
	self assert: p numberOfFiles equals: 1.

	f := p files anyOne.
	self assert: f loc equals: self file02 lines size.
	self assert: f importedFilenames equals: #('warnings' 'os' 're' 'sys' 'colorsys' 'numpy' '__future__' 'random' 'operator' 'PIL' '.query_integral_image' '.tokenization').
	self assert: f baseFilenameWithoutExtension equals: 'wordcloud'.
	self assert: f baseFilename equals: 'wordcloud.py'.
]

{ #category : #tests }
PyProcessorTest >> testBasic03 [
	| m1 m2 |
	p processFileAsString: self file02 named: 'wordcloud.py'.
	p processFileAsString: self file03 named: '__init__.py'.
	p processFileAsString: self file04 named: 'color_from_image.py'.
	p processFileAsString: self file05 named: 'tokenization.py'.
	p processFileAsString: self file06 named: 'wordcloud_cli.py'.
	p resolveDependencies.
	
	self assert: p numberOfModules equals: 5.
	
	m1 := p moduleNamed: 'wordcloud.py'.
	m2 := p moduleNamed: 'wordcloud_cli.py'.
	self assert: m1 dependentModules size equals: 2.
	self assert: m1 dependentModules first equals: m2.
	self assert: m2 dependentModules size equals: 0.
]

{ #category : #tests }
PyProcessorTest >> testBasic04 [
	| m1 |
	p processFileAsString: self file02 named: 'wordcloud.py'.
	p processFileAsString: self file03 named: 'init.py'.
	p processFileAsString: self file04 named: 'color_from_image.py'.
	p processFileAsString: self file05 named: 'tokenization.py'.
	p processFileAsString: self file06 named: 'wordcloud_cli.py'.
	p resolveDependencies.
	
	m1 := p moduleNamed: 'init'.
	
	self assert: m1 equals: nil.
	m1 := p moduleNamed: 'init.py'.
	self assert: m1 notNil.
	
	self assert: m1 importedFilenames size equals: 2.
	self assert: m1 importedFiles size equals: 2.
]

{ #category : #tests }
PyProcessorTest >> testBasic05 [
	| m1 |
	p processFileAsString: self file02 named: 'wordcloud.py'.
	p resolveDependencies.
	m1 := p moduleNamed: 'wordcloud.py'.
	self assert: m1 filename equals: 'wordcloud.py'.
	self assert: (m1 fileReference isKindOf: FileReference).
]

{ #category : #tests }
PyProcessorTest >> testBasic06 [
	| m1 ff |
ff := '
"""
from my world is your world
"""
'.
	p processFileAsString: ff named: 'wordcloud.py'.
	p resolveDependencies.
	m1 := p moduleNamed: 'wordcloud.py'.
	self assert: m1 filename equals: 'wordcloud.py'.
	self assert: (m1 fileReference isKindOf: FileReference).
]

{ #category : #tests }
PyProcessorTest >> testBasic07 [
	| m1 ff relevantLines |
ff := '
"""
from my world is your world
"""
'.
	relevantLines := PyFile new getRelevantLinesOf: ff lines.
	self assert: relevantLines size equals: 2.
]

{ #category : #'tests - import' }
PyProcessorTest >> testFromImport [
	| f1 f2 f3 main foobar schemaMapper |
	f1 := 'from schemaMapper import zork
from foobar import foo

if __name__ == ''__main__'':
    print(''Foo = %d'' % (foo(zork())))
'.

	f2 := '
def foo(n):
    return 42 + n
'.

	f3 := 'def zork():
    return 5
'.

	p processFileAsString: f1 named: 'main.py'.
	p processFileAsString: f2 named: 'foobar.py'.
	p processFileAsString: f3 named: 'schemaMapper.py'.
	p resolveDependencies.
	
	self assert: p numberOfModules equals: 3.
	main := p moduleNamed: 'main.py'.
	foobar := p moduleNamed: 'foobar.py'.
	schemaMapper := p moduleNamed: 'schemaMapper.py'.
	
	self assert: main importedFilenames equals: #('schemaMapper' 'foobar').
	self assert: main importedFiles size equals: 2.
	self assert: main importedFiles first equals: schemaMapper.
	self assert: main importedFiles second equals: foobar.
]

{ #category : #'tests - import' }
PyProcessorTest >> testFromImportAs [
	"This semantic is not clear to me.... We need to work on this"
	| f1 f2 f3 main foobar schemaMapper |
	f1 := 'import schemaMapper as s
import foobar as bar

if __name__ == ''__main__'':
    print(''Foo = %d'' % (bar.foo(s.zork())))
'.

	f2 := '
def foo(n):
    return 42 + n
'.

	f3 := 'def zork():
    return 5
'.

	p processFileAsString: f1 named: 'main.py'.
	p processFileAsString: f2 named: 'rep/foobar.py'.
	p processFileAsString: f3 named: 'rep/schemaMapper.py'.
	p resolveDependencies.
	
	self assert: p numberOfModules equals: 3.
	main := p moduleNamed: 'main.py'.
	foobar := p moduleNamed: 'foobar.py'.
	schemaMapper := p moduleNamed: 'schemaMapper.py'.
	
	self assert: main importedFilenames equals: #('schemaMapper' 'foobar').
	self assert: main importedFiles size equals: 2.
	self assert: main importedFiles first equals: schemaMapper.
	self assert: main importedFiles second equals: foobar.
]

{ #category : #'tests - import' }
PyProcessorTest >> testFromImportWithStar [
	"This semantic is not clear to me.... We need to work on this"
	| f1 f2 f3 main foobar schemaMapper |
	f1 := 'from .rep.schemaMapper import *
from .rep.foobar import *

if __name__ == ''__main__'':
    print(''Foo = %d'' % (foo(zork())))
'.

	f2 := '
def foo(n):
    return 42 + n
'.

	f3 := 'def zork():
    return 5
'.

	p processFileAsString: f1 named: 'main.py'.
	p processFileAsString: f2 named: 'rep/foobar.py'.
	p processFileAsString: f3 named: 'rep/schemaMapper.py'.
	p resolveDependencies.
	
	self assert: p numberOfModules equals: 3.
	main := p moduleNamed: 'main.py'.
	foobar := p moduleNamed: 'foobar.py'.
	schemaMapper := p moduleNamed: 'schemaMapper.py'.
	
	self assert: main importedFilenames equals: #('.rep.schemaMapper' '.rep.foobar').
	self assert: main importedFiles size equals: 2.
	self assert: main importedFiles first equals: schemaMapper.
	self assert: main importedFiles second equals: foobar.
]

{ #category : #'tests - functions parsing' }
PyProcessorTest >> testFunctions01 [
 
	| firstFile functions |
	p processFileAsString: self file05 named: 'tokenization.py'.
	self assert: p numberOfFunctions equals: 5.
	firstFile := p files values first.
	self assert: firstFile numberOfFunctions equals: 5.
	
	functions := firstFile functions.
	self assert: functions equals: p functions.
	self assert: functions first name equals: 'l'.
	self assert: functions second name equals: 'score'.
	self assert: functions last name equals: 'process_tokens'.
	
	self assert: functions first numberOfLinesOfCode equals: 7.
	self assert: functions third numberOfLinesOfCode equals: 9.
	self assert: functions last numberOfLinesOfCode equals: 62.
]

{ #category : #'tests - functions parsing' }
PyProcessorTest >> testFunctions02CallNames [
 
	| firstFile functions firstFunction |
	p processFileAsString: self file05 named: 'tokenization.py'.
	firstFile := p files values first.
	functions := firstFile functions.
	firstFunction := functions first.
	
	self assert: firstFunction name equals: 'l'.
	self assert: firstFunction callNames asArray equals: (Array with: 'log' with: 'max' with: 'log' with: 'max')
]

{ #category : #'tests - import' }
PyProcessorTest >> testImport [
	| f1 f2 f3 main foobar schemaMapper |
	f1 := 'import schemaMapper
import foobar

if __name__ == ''__main__'':
    print(''Foo = %d'' % (foobar.foo(schemaMapper.zork())))
'.

	f2 := '
def foo(n):
    return 42 + n
'.

	f3 := 'def zork():
    return 5
'.

	p processFileAsString: f1 named: 'main.py'.
	p processFileAsString: f2 named: 'foobar.py'.
	p processFileAsString: f3 named: 'schemaMapper.py'.
	p resolveDependencies.
	
	self assert: p numberOfModules equals: 3.
	main := p moduleNamed: 'main.py'.
	foobar := p moduleNamed: 'foobar.py'.
	schemaMapper := p moduleNamed: 'schemaMapper.py'.
	
	self assert: main importedFilenames equals: #('schemaMapper' 'foobar').
	self assert: main importedFiles size equals: 2.
	self assert: main importedFiles first equals: schemaMapper.
	self assert: main importedFiles second equals: foobar.
]

{ #category : #'tests - functions parsing' }
PyProcessorTest >> testNoFunctions [
 
	self assert: p numberOfFunctions equals: 0.
	
]

{ #category : #'tests - oop' }
PyProcessorTest >> testOOP00 [

	| m |
	p processFileAsString: '' named: 'emptyFile.py'.
	m := p modules anyOne.
	self deny: m containsMain.
	
	self assert: m numberOfClasses equals: 0.
	self assert: m numberOfMethods equals: 0
]

{ #category : #'tests - oop' }
PyProcessorTest >> testOOP01 [

	| m |
	p processFileAsString: self codeOOP named: 'codeOOP.py'.
	m := p modules anyOne.
	self assert: m containsMain.
	
	self assert: m numberOfClasses equals: 2.
	self assert: m numberOfMethods equals: 3
]

{ #category : #tests }
PyProcessorTest >> testRelevantLines01 [
	| ff relevantLines |
ff := '
"""from my world is your world"""
'.
	relevantLines := PyFile new getRelevantLinesOf: ff lines.
	self assert: relevantLines size equals: 2.
	self assert: relevantLines first equals: ''.
	self assert: relevantLines second equals: '"""from my world is your world"""'.
]

{ #category : #tests }
PyProcessorTest >> testRelevantLines02 [
	| ff relevantLines |
ff := '
"""
from my world is your world
"""
'.
	relevantLines := PyFile new getRelevantLinesOf: ff lines.
	self assert: relevantLines size equals: 2.
]
