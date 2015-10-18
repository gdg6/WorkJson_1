module Admin::EventsHelper
	def getAllCharacters
		res = []
		Character.select(:title, :id	).all.each{|x| res << x}
		return res
	end
end
