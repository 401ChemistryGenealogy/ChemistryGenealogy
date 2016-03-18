# @author Steven Myers
# this class is used to verify unapproved information, basically all the
# methods just turn approved = true for respective entries
class Verifier

  # yeah it does what you think
  def self.verify_user(user_id)
    @user = User.find_by_id(user_id)

    @user.approved = true
    if @user.save
      return {'user' => @user}
    else
      return nil
    end
  end

  def self.verify_admin(admin_id)
    @admin = Admin.find_by_id(admin_id)
    @admin.approved = true
    if @admin.save
      return {'admin' => @admin}
    else
      return nil
    end
  end

  def self.verify_mentorship(mentorship_id)
    @mentorship = Mentorship.includes(:institution)
                  .where(:id => mentorship_id).first

    if @mentorship.institution.approved == false
      @mentorship.institution.approved = true
    end

    @mentorship.approved = true

    if @mentorship.save && @mentorship.institution.save
      return {
        'mentorship' => @mentorship,
        'institution' => @mentorship.institution
      }
    else
      return nil
    end
  end

  def self.verify_supervision(supervision_id)
    @supervision = Supervision.includes(degree: :institution)
                    .where(:id => supervision_id).first

    if @supervision.degree.approved == false
      @supervision.degree.approved = true
    end

    if @supervision.degree.institution.approved == false
      @supervision.degree.institution.approved = true
    end

    @supervision.approved = true

    if @supervision.save && @supervision.degree.save && @supervision.degree.institution.save
      return {
        'supervision' => @supervision,
        'degree' => {
          'data' => @supervision.degree,
          'institution' => @supervision.degree.institution
        }
      }
    else
      return nil
    end
  end

  # goes through every single thing related to a person and approves it
  # if a user approves a person, they also approve everything related to that
  # person. So, if you see something funny on an unapproved person's details,
  # then you shouldn't improve.
  # TODO: this method is very slow. Investigate optimizations. 
  def self.verify_person(person_id)
    @person = Search.person_info(person_id)

    if @person["person"].approved == false
      @person["person"].approved = true
      @person["person"].save
    end
    if @person["person"].institution.approved == false
      @person["person"].institution.approved = true
      @person["person"].institution.save
    end

    @person["person"].mentorships.each do |m|
      m.approved = true
      m.institution.approved = true
      m.mentor.approved = true
      m.mentor.institution.approved = true
      m.mentor.institution.save
      m.mentor.save
      m.institution.save
      m.save
    end

    @person["person"].supervisions.each do |s|
      s.approved = true
      s.degree.approved = true
      s.degree.institution.approved = true
      s.supervisor.institution.approved = true
      s.supervisor.approved = true
      s.save
      s.degree.save
      s.degree.institution.save
      s.supervisor.institution.save
      s.supervisor.save
    end

    @person["mentored"].each do |m|
      m.approved = true
      m.institution.approved = true
      m.person.approved = true
      m.person.institution.approved = true
      m.person.institution.save
      m.person.save
      m.institution.save
      m.save
    end

    @person["supervised"].each do |s|
      s.approved = true
      s.degree.approved = true
      s.degree.institution.approved = true
      s.person.approved = true
      s.person.institution.approved = true
      s.save
      s.degree.save
      s.degree.institution.save
      s.person.save
      s.person.institution.save
    end

    return {
      'warning' => "person approved, but with no error checking"
    }
  end
end
