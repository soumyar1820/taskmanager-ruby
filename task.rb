class Tasks
	
	attr_accessor :id, :content, :completed

	def initialize(id, content)
		@id = id
		@content = content
		@completed = false
	end

	def to_csv
		[id,content,completed ? ' completed': 'not completed']
	end

	def mark_completed
    	@completed = true
	end

end