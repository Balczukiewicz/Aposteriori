defmodule Apriori do
  @moduledoc """
  Documentation for `Apriori`.
  """
import Statistics
  @spec generate_random_numbers_from_poissoins :: list
  @doc """
  Aposteriori from poisson distribution
  """
  def generate_random_numbers_from_poissoins do

    poiss_distr = Enum.map(0..999, fn(x) -> Statistics.Distributions.Poisson.rand(7) end)
    poiss_distr
  end

  @spec aposteriori(mean_apriori::integer(), sd_apriori::integer) :: number
  def aposteriori(mean_apriori, sd_apriori) do

  variance_apriori = sd_apriori ** 2

  alpha_apriori = mean_apriori ** 2 /variance_apriori
  beta_apriori = mean_apriori / variance_apriori

  alpha_aposteriori = []
  beta_aposteriori = []

  poiss_distr = Apriori.generate_random_numbers_from_poissoins()

  IO.puts("alpha")
  alpha_aposteriori = Apriori.alpha(1,alpha_aposteriori ++ [alpha_apriori],poiss_distr)
  IO.puts("beta")
  beta_aposteriori = Apriori.beta(1,beta_aposteriori ++ [beta_apriori])
  sum_of_poiss = poiss_distr |> Enum.sum()
  IO.puts("mnw")
  mnw = sum_of_poiss / length(poiss_distr)

  # for (i in 2:1001) {
  #   alpha_aposteriori[i]<-poiss_dist[i-1]+alpha_aposteriori[i-1]
  #   beta_aposteriori[i]<-1+beta_aposteriori[i-1]
  # }
  # end
  #Estymator bayesowski - wartosc oczekiwana rozkladu aposteriori
  IO.puts("Bayesian Estimator")
  Apriori.div_lists([],alpha_aposteriori, beta_aposteriori) |> IO.inspect()
  #sd_aposteriori <- sqrt(alpha_aposteriori/beta_aposteriori^2)
  beta_aposteriori_sqrt =
     beta_aposteriori
  |> Enum.map(&(:math.sqrt(&1)))

  IO.puts("sd_aposteriori")
  Apriori.sd_aposteriori([],alpha_aposteriori, beta_aposteriori_sqrt)
end

  def sd_aposteriori(ans, alpha_aposteriori = [alpha|alpha_tail],beta_aposteriori_sqrt = [beta_sqrt|beta_tail]) do
    value = :math.sqrt(alpha/beta_sqrt)
    sd_aposteriori(ans ++ [value],alpha_tail,beta_tail)
  end

  def sd_aposteriori(ans,[],[]), do: ans

  def div_lists(ans ,alpha_aposteriori = [alpha|alpha_tail],beta_aposteriori = [beta|beta_tail]) do
    value = alpha/beta

    div_lists(ans ++ [value], alpha_tail, beta_tail)
  end

  def div_lists(ans, [], []), do: ans

  def parts_sums(ls) do
    Apriori.answer(ls)
    end

    def answer([]), do: 0

    def answer(ls) do
    a = Enum.sum(ls)
    [a] ++ Apriori.answer(ls)

  end


  def alpha(n, alpha_aposteriori, poiss_distr) when n < 1000 do

    value = List.last(alpha_aposteriori) + Enum.at(poiss_distr, n)

    Apriori.alpha(n+1, alpha_aposteriori ++ [value], poiss_distr)
  end

def alpha(n, alpha_aposteriori, poiss_distr) when n == 1000 do
  alpha_aposteriori |> IO.inspect()
   alpha_aposteriori
end

def beta(n, beta_aposteriori) when n == 1000 do
  beta_aposteriori |> IO.inspect()
  beta_aposteriori
end


def beta(n, beta_aposteriori) when n < 1000 do
  value = List.last(beta_aposteriori) + 1

  beta(n+1, beta_aposteriori ++ [value])
end



    def squares_in_rect(l, w) do
      Apriori.squares(l,w, [])
    end

    def squares(1,1, tab) do
      [1|tab]
    end

    def squares(l,w, tab) when l >= w do
      tab ++ [w] ++ Apriori.squares(l-w, w, tab)
    end
    def squares(l,w, tab) when l < w do

      tab ++ [l] ++ Apriori.squares(w-l, l, tab)
    end
  end
