require 'minitest/autorun'
require 'minitest/pride'
require './lib/dictionary'

class DictionaryTest < Minitest::Test

  def test_it_exists_and_has_attributes
    dictionary = Dictionary.new

    assert_instance_of Dictionary, dictionary
    assert_equal Hash, dictionary.letter_equivalents.class
    assert_equal 27, dictionary.letter_equivalents.size
    assert_equal '.0\n0.\n..', dictionary.letter_equivalents['z']
  end

  def test_convert
    dictionary = Dictionary.new

    assert_equal '.0\n0.\n..', dictionary.convert('z')
  end
end
