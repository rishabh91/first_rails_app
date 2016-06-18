require 'httparty'

class FreshdeskTicketWorker
	include Sidekiq::Worker 
	def initialize(hash)
		@tickHash=hash
	end
	def perform(args=nil)
		# tickHash will be passed to the worker by the calling method where it will contain the various details to 
		## create a ticket inside the helpdesk
		## sampleHash={:email => "sample@sample.com" (This will be the ticket requester email)
					#	:description =>"#{flipkart_prod_url} && #{amazon_url} && #{sanpdeal_url}"
					#	:subject => "ticket subject",
					#   :priority => "This accepts integers"(1=> Low, 2=> Mediume ,3 => High, 4 => Urgent)
					#	}
		
		
		response= HTTParty.post("#{@base_url}/helpdesk/tickets.json",
				  :body => {@tickHash}.to_json,
				  :basic_auth => (auth),
				  :headers => { 'Content-Type' => 'application/json'}
				  )
		if response.code==200
			puts " the ticket created successfully"
		else
			failed_job(tickHash)
		end
		FreshdeskTicketWorker.perform_in(1.day,nil)
	end
end



		









private
	def auth
		auth = {:username => "bla bla", :password => "bulshit" }
	end

	def failed_job acceptsHash
		#will do something
	end
end
