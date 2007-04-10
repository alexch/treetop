require 'rubygems'
require 'spec/runner'

dir = File.dirname(__FILE__)
require "#{dir}/../spec_helper"
require "#{dir}/metagrammar_spec_context_helper"

context "The subset of the metagrammar rooted at the parsing_rule rule" do
  include MetagrammarSpecContextHelper
  
  setup do
    @root = :parsing_rule
  end

  specify "parses an empty string" do
    with_both_protometagrammar_and_metagrammar do
      result = parse_result_for("rule foo 'bar' end")
   
      result.should be_an_instance_of(ParsingRule)
    end
  end
  
  specify "parses a parse rule with a terminal symbol as its expression" do
    with_both_protometagrammar_and_metagrammar do
      result = parse_result_for("rule foo 'bar' end")
   
      result.should be_an_instance_of(ParsingRule)
      result.nonterminal_symbol.name.should == :foo
      result.parsing_expression.should be_an_instance_of(TerminalSymbol)      
    end
  end

  specify "parses a parse rule with a nasty fucking expression" do
    with_both_protometagrammar_and_metagrammar do
      result = parse_result_for("rule foo 'bar' baz+ (xyzzy / plugh*) !bar end")
   
      result.should be_an_instance_of(ParsingRule)      
    end
  end
end
