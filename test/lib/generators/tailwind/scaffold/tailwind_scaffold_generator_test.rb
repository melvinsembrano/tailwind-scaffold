require "test_helper"
require "generators/tailwind_scaffold/tailwind_scaffold_generator"

module Tailwind::Scaffold
  class TailwindScaffoldGeneratorTest < Rails::Generators::TestCase
    tests TailwindScaffoldGenerator
    destination Rails.root.join("tmp/generators")
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
