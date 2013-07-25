class RecommendationsController < ApplicationController
	def results
		@text = params[:text]
		pipeline =  StanfordCoreNLP.load(:tokenize, :ssplit, :pos, :lemma, :parse, :ner, :dcoref)
		@text = StanfordCoreNLP::Annotation.new(@text)
		pipeline.annotate(@text)
		@all_dep = ""
		@text.get(:sentences).each do |sentence|
			# Syntatical dependencies
		  	@all_dep += sentence.get(:basic_dependencies).to_s #or collapsed
		  	#sentence.get(:tokens).each do |token|
			    # Default annotations for all tokens
			    #puts "Value: " + token.get(:value).to_s
			    #puts token.get(:original_text).to_s
			    #puts token.get(:character_offset_begin).to_s
			    #puts token.get(:character_offset_end).to_s
			    # POS returned by the tagger
			    #puts "Parts of Speech: " + token.get(:part_of_speech).to_s
			    # Lemma (base form of the token)
			    #puts "Lemma: " + token.get(:lemma).to_s
			    # Named entity tag
			    #puts "Named entity tag: " + token.get(:named_entity_tag).to_s
			    # Coreference
			    #puts "Coreferenced cluster ID: " + token.get(:coref_cluster_id).to_s
			    # Also of interest: coref, coref_chain, 
			    # coref_cluster, coref_dest, coref_graph.
		  	#end
		end
		File.open('testing1.txt', 'w') { |f| f.write(@all_dep) }
		#@all_dep = @all_dep.split("->")[1].split("\n")

		# Get number of spaces
		# @all_dep = @all_dep.split("->")[1].split("\n")[1]

		
		respond_to do |format|
      		#format.html { redirect_to root_url }
      		format.js
    	end
	end
end
