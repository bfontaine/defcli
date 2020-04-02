class DefcliFormattingTest < Test::Unit::TestCase

  # == Defcli::Formatting.format_results == #

  def test_format_results_empty_list
    assert_equal('', Defcli.format_results([]))
  end

  def test_format_results_one_element_no_color
    res = {
      :word => 'XYZ',
      :upvotes => 42,
      :downvotes => 78,
      :definition => 'xyz',
      :example => 'zyx'
    }

    output = Defcli.format_results([res], false).strip
    expected = <<EOS
* XYZ (42/78):

    xyz

 Example:
    zyx
EOS

    assert_equal(expected.strip, output)
  end

  def test_format_results_one_element_color
    green = "\e[32m"
    bold  = "\e[1m"
    red   = "\e[31m"
    reset = "\e[0m"
    res = {
      :word => 'XYZ',
      :upvotes => 42,
      :downvotes => 78,
      :definition => 'xyz',
      :example => 'zyx'
    }

    output = Defcli.format_results([res], true).strip
    expected = <<EOS
* #{bold}XYZ#{reset} (#{green}42#{reset}/#{red}78#{reset}):

    xyz

 Example:
    zyx
EOS

    assert_equal(expected.strip, output)
  end

  # == Defcli::Formatting.fit == #

  def test_fit_0_width
    assert_equal([], Defcli::Formatting.fit('foo', 0))
  end

  def test_fit_negative_width
    assert_equal([], Defcli::Formatting.fit('foo', -1))
  end

  def test_fit_right_width
    assert_equal(['foo'], Defcli::Formatting.fit('foo', 3))
  end

  def test_fit_larger_width
    assert_equal(['foo'], Defcli::Formatting.fit('foo', 4))
  end

  def test_fit_smaller_width
    assert_equal(['a', 'b'], Defcli::Formatting.fit('a b', 2))
  end

  # == Defcli::Formatting.tab == #

  def test_tab_0_width
    assert_equal('foo', Defcli::Formatting.tab('foo', 0))
  end

  def test_tab_negative_width
    assert_equal('foo', Defcli::Formatting.tab('foo', -1))
  end

  def test_tab_2_width
    assert_equal('  foo', Defcli::Formatting.tab('foo', 2))
  end

  def test_tab_array
    assert_equal([' a', ' b'], Defcli::Formatting.tab(['a', 'b'], 1))
  end
end
