desc 'wikirace_update'
task wikirace_update: :environment do
        @wikirace = Wikirace.where(racedate: Date.today).first
        if @wikirace.blank?
            # no wikirace - try to find a wikirace from the past
            @new_wikirace = Wikirace.where("extract(MONTH FROM racedate) = ? and extract(DAY from racedate) = ?", Date.today.month, Date.today.day).order("RANDOM()").first
            if not @new_wikirace.blank?
                # if the new wikirace exists, change the date of it
                @new_wikirace.racedate = Date.today
                @new_wikirace.save
            end
        end
end