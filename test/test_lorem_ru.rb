require 'helper'

class TestLoremRU < Test::Unit::TestCase
  include DeterministicHelper

  SENTENCE_MATCHER = /\A[а-яА-ЯёЁ\-\s\.\!\?,]+\z/.freeze
  WORDS_MATCHER    = /\A[А-Яа-яёЁ\-\s]+\z/.freeze
  WORD_MATCHER     = /\A[А-Яа-яёЁ\-]+\z/.freeze

  assert_methods_are_deterministic(
    FFaker::LoremRU,
    :paragraph, :sentence, :words, :word
  )

  def setup
    @tester = FFaker::LoremRU
  end

  def test_word
    assert_match(WORD_MATCHER, @tester.word)
  end

  def test_words
    @tester.words(10).each do |word|
      assert_match(WORD_MATCHER, word)
    end
    assert_match(WORDS_MATCHER, @tester.words.join(' '))
  end

  def test_sentence
    assert_match(SENTENCE_MATCHER, @tester.sentence(20))
    assert_match(SENTENCE_MATCHER, @tester.sentence(4))
  end

  def test_sentences
    @tester.sentences(10).each do |sentence|
      assert_match(SENTENCE_MATCHER, sentence)
    end
  end

  def test_paragraph
    assert_match(SENTENCE_MATCHER, @tester.paragraph)
  end

  def test_paragraphs
    @tester.paragraphs.each do |paragraph|
      assert_match(SENTENCE_MATCHER, paragraph)
    end
  end
end
