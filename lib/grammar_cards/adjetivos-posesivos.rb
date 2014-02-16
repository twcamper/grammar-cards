#! /usr/bin/env ruby
# encoding: utf-8
require './possessives'

# noun file
# completed structure file
# used noun list
# structure list
#   singular definite article
#   plural   definite article
#   1st person singular
#   1st person plural masculine
#   1st person plural feminine
#   2nd person singular formal
#   2nd person singular familiar
#   2nd person plural formal
#   2nd person plural masculine familiar
#   2nd person plural feminine  familiar
#   3rd person singular masculine
#   3rd person singular feminine
#   3rd person plural masculine
#   3rd person plural feminine

# generate each structure with each noun
#   don't repeat a structure with a noun until all of the other nouns 
#   have been used
#   if possible, use each noun only once per session, such that each
#   structure has a unique noun

# Read noun file into array

# Randomize order of structures

# for each structure
#   build list of candidate nouns
#     build list of nouns unused for the structure
#     if 0
#       remove all entries for the structure from the file
#       return all nouns
#
#     get difference of session-used list and unused list
#     if 0
#       candidate list is unused list
#     else
#       candidate list is that difference
#   select from candidate list at random
#   write noun-structure pair to the completed structure file
#   add noun to session-used list
#


[
 [{:person => 1, :number => :s}, {:number => :s}],
 [{:person => 1, :number => :s}, {:number => :p}],
 [{:person => 1, :number => :p}, {:number => :s, :gender => :m}],
 [{:person => 1, :number => :p}, {:number => :s, :gender => :f}],
 [{:person => 1, :number => :p}, {:number => :p, :gender => :m}],
 [{:person => 1, :number => :p}, {:number => :p, :gender => :f}],
 [{:person => 2, :number => :s, :register => :familiar}, {:number => :s}],
 [{:person => 2, :number => :s, :register => :familiar}, {:number => :p}],
 [{:person => 2, :number => :p, :register => :familiar}, {:number => :s, :gender => :m}],
 [{:person => 2, :number => :p, :register => :familiar}, {:number => :s, :gender => :f}],
 [{:person => 2, :number => :p, :register => :familiar}, {:number => :p, :gender => :m}],
 [{:person => 2, :number => :p, :register => :familiar}, {:number => :p, :gender => :f}],
 [{:person => 2, :number => :s, :register => :formal}, {:number => :s, :gender => :m}],
 [{:person => 2, :number => :s, :register => :formal}, {:number => :s, :gender => :f}],
 [{:person => 2, :number => :s, :register => :formal}, {:number => :p, :gender => :m}],
 [{:person => 2, :number => :s, :register => :formal}, {:number => :p, :gender => :f}],
 [{:person => 2, :number => :p, :register => :formal}, {:number => :s, :gender => :m}],
 [{:person => 2, :number => :p, :register => :formal}, {:number => :s, :gender => :f}],
 [{:person => 2, :number => :p, :register => :formal}, {:number => :p, :gender => :m}],
 [{:person => 2, :number => :p, :register => :formal}, {:number => :p, :gender => :f}],
 [{:person => 3, :number => :s, :gender => :m}, {:number => :s}],
 [{:person => 3, :number => :s, :gender => :m}, {:number => :p}],
 [{:person => 3, :number => :s, :gender => :f}, {:number => :s}],
 [{:person => 3, :number => :s, :gender => :f}, {:number => :p}],
 [{:person => 3, :number => :p, :gender => :m}, {:number => :s}],
 [{:person => 3, :number => :p, :gender => :m}, {:number => :p}],
 [{:person => 3, :number => :p, :gender => :f}, {:number => :s}],
 [{:person => 3, :number => :p, :gender => :f}, {:number => :p}],
].each do |owner, owned|
  adj =  Español::Possessive::Adjective.build(owner, owned)
  print owner, owned, "\t", adj
  if adj =~ /^su/
    print "\t", Español::Possessive::PronounPhrase.build(owner)
  end
  puts
  
end
