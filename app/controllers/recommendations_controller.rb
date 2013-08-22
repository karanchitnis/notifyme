class RecommendationsController < ApplicationController
	def results
		text = params[:text]
		pipeline =  StanfordCoreNLP.load(:tokenize, :ssplit, :pos, :lemma, :parse, :ner, :dcoref)
		text = StanfordCoreNLP::Annotation.new(text)
		pipeline.annotate(text)
		all_dep = ""
		text.get(:sentences).each do |sentence|
			# Syntatical dependencies
		  	all_dep += sentence.get(:basic_dependencies).to_s #or collapsed
		  	#sentence.get(:tokens).each do |token|
			    # POS returned by the tagger
			    #puts "Parts of Speech: " + token.get(:part_of_speech).to_s
			    # Named entity tag
			    #puts "Named entity tag: " + token.get(:named_entity_tag).to_s
			    # Coreference
			    #puts "Coreferenced cluster ID: " + token.get(:coref_cluster_id).to_s
			#end
		end

		spaces = 0
		# height of 0 = root, height 1 are lines with 2 spaces, etc
		last_nodes = []
		root_node = Tree::TreeNode.new("All Sentences", "root")
		for line in all_dep.lines
			while line[spaces] != "-"
				spaces += 1
			end
			
			last_nodes[(spaces / 2)] = line			
			arr_ind = 0
			cur_node = root_node
			while arr_ind < (spaces / 2)
				cur_node = cur_node[last_nodes[arr_ind].split('>')[1].split('-')[0].split[0]]
				arr_ind += 1
			end
			cur_node << Tree::TreeNode.new(line.split('>')[1].split('-')[0].split[0], line.split('>')[1].split('-')[1])
			spaces = 0
		end
		@str_node = cur_node[0].name
		File.open('testing1.txt', 'w') { |f| f.write(root_node.print_tree) }
		respond_to do |format|
      		format.js
    	end
	end
end