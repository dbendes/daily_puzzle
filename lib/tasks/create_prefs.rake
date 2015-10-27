desc 'create_prefs'
task create_prefs: :environment do
    User.all.each do |user|
        pref = EmailPreference.create
        user.email_preference = pref
        user.save
    end
end