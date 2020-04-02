# -*- coding: UTF-8 -*-

module Defcli
  module Formatting
    class << self
      # Fit a text in a given width (number of chars).
      # @param txt [String]
      # @param width [Integer] maximum width
      # @return [Array] list of lines of text
      def fit(txt, width = 79)
        return [] if width < 1

        # from https://stackoverflow.com/a/7567210/735926
        r = /(.{1,#{width}})(?:\s|$)/m
        txt.split("\n").map { |l| l.scan(r) }.flatten
      end

      # Add a tab at the beginning of a text. If it's a list, add a tab at
      # the beginning of each element.
      # @param txt [String] The text to tab, may be a string or a list of
      #                     strings
      # @param width [Integer] tab width
      # @return [String]
      def tab(txt, width = 4)
        return txt if width <= 0

        tab = " " * width

        return tab + txt if txt.is_a? String

        txt.map { |l| tab + l }
      end

      # Format results for text output (e.g. in the terminal)
      # @param results [Array<Hash>] array of results
      # @param color [Boolean] colored output
      # @return [String]
      def format_results(results, color = true)
        results.map { |r| format_result(r, color) }.join "\n"
      end

      def format_result(r, color = true)
        require "colored" if color

        word = r[:word]
        word = word.bold if color

        rating = format_result_rating(r, color)

        definition = tab(fit(r[:definition], 75)).join "\n"

        text = "* #{word}"
        text << " (#{rating})" if rating
        text << ":\n\n#{definition}\n"

        text << "(📍 #{r[:location]})\n" if r[:location]

        text << (format_result_examples(r, color) or "")

        text + "\n\n"
      end

      private

      def format_result_examples(r, color = true)
        examples = if r[:example]
                     [r[:example]]
                   elsif r[:examples]
                     r[:examples]
                   else
                     []
                   end

        if examples.count == 1
          example = tab(fit(examples.first, 75)).join "\n"
          "\n Example:\n#{example}\n"

        elsif examples.count > 1
          examples = examples.map do |e|
            tab(fit(e, 75)).join "\n"
          end.join "\n"
          "\n Examples:\n#{examples}\n"
        end
      end

      def format_result_rating(r, color = true)
        if r[:upvotes]
          # upvotes/downvotes
          upvotes = r[:upvotes]
          downvotes = r[:downvotes]
          if color
            upvotes   = upvotes.to_s.green
            downvotes = downvotes.to_s.red
          end

          "#{upvotes}/#{downvotes}"
        elsif r[:ratio]
          percentage = r[:ratio] * 100.0
          rating = format("%2d%%", percentage)

          if color
            if percentage > 60
              rating = rating.green
            else
              rating = rating.red
            end
          end

          rating
        end
      end
    end
  end
end
