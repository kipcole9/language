defmodule Text.Language.Classifier.CumulativeFrequency do
  @moduledoc """
  A language detection model that uses cumulative
  frequencies

  It sums the frequencies of detected
  n-grams.

  """
  @no_entry %Text.Ngram.Frequency{
    rank: 1000,
    count: 0,
    frequency: 0,
    global_rank: 1000,
    global_frequency: 0,
    log_frequency: :math.log(5.0e-6)
  }

  @doc """
  Sums the frequencies of each n-gram

  A strong negative weighting is
  applied if the n-gram is not contained
  in the given vocabulary.
  """
  def score_one_language(language, text_ngrams, vocabulary) do
    vocab = vocabulary.get_vocabulary(language)

    score =
      text_ngrams
      |> Enum.reduce(0, fn {ngram, %{count: count}}, acc ->
        ngram_stats = Map.get(vocab, ngram, @no_entry)
        acc + count * ngram_stats.frequency
      end)

    {language, score}
  end

  @doc """
  Return the `{language score}` tuples
  in the correct order for this classifier.

  """
  def order_scores(scores) do
    scores
    |> Enum.sort(fn
      {ngram1, score}, {ngram2, score} -> ngram1 > ngram2
      {_, score1}, {_, score2} -> score1 >= score2
    end)
  end
end
