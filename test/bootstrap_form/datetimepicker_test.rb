require "test_helper"

class BootstrapFromDatetimepickerTest < ActionView::TestCase
  def setup
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? "schedules"
    Schedule.delete_all

    @schedule = Schedule.new
    @builder =  BootstrapForm::FormBuilder.new(:schedule, @schedule, self, {})
    @horizontal_builder = BootstrapForm::FormBuilder.new(:schedule, @schedule, self, { layout: :horizontal })
  end

  test "render datetimepicker correctly in normal layout" do
    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD HH:mm:ss ZZ">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    assert_equal expected, @builder.datetime_picker(:until)
  end

  test "render datetimepicker correctly in horizontal layout" do
    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label col-sm-2" for="schedule_until">Until</label>
  <div class="col-sm-10">
    <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD HH:mm:ss ZZ">
      <input class="form-control" id="schedule_until" name="schedule[until]" type="text" />
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar">
        </span>
      </span>
    </div>
  </div>
</div>
    HTML

    assert_equal expected, @horizontal_builder.datetime_picker(:until)
  end

  test "use :datetimepicker_class option for wrapping div element's class" do
    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label col-sm-2" for="schedule_until">Until</label>
  <div class="col-sm-10">
    <div class="custom-datetimepicker-class input-group date" data-date-format="YYYY-MM-DD HH:mm:ss ZZ">
      <input class="form-control" id="schedule_until" name="schedule[until]" type="text" />
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar">
        </span>
      </span>
    </div>
  </div>
</div>
    HTML

    assert_equal expected, @horizontal_builder.datetime_picker(:until, :datetimepicker_class => "custom-datetimepicker-class")
  end

  test "put object's value for value attribute" do
    @schedule.until = Time.now

    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD HH:mm:ss ZZ">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" value="#{@schedule.until.to_s}" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    assert_equal expected, @builder.datetime_picker(:until)
  end

  test "use Time::DATE_FORMATS' format for value attribute and data-date-format attribute when :format option is specified by its name" do
    @schedule.until = Time.now
    Time::DATE_FORMATS[:custom] = "%Y-%m-%d"

    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" value="#{@schedule.until.to_s(:custom)}" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    assert_equal expected, @builder.datetime_picker(:until, :format => :custom)
  end

  test "use format specified with :format option for value attribute and data-date-format attribute" do
    @schedule.until = Time.now

    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" value="#{@schedule.until.strftime("%Y-%m-%d")}" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    assert_equal expected, @builder.datetime_picker(:until, :format => "%Y-%m-%d")
  end

  test "use :datetimepicker_format option for data-date-format attribute" do
    @schedule.until = Time.now

    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MMMM-DDDD">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" value="#{@schedule.until.strftime("%Y-%m-%d")}" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    assert_equal expected, @builder.datetime_picker(:until, :format => "%Y-%m-%d", :datetimepicker_format => "YYYY-MMMM-DDDD")
  end

  test "configure global :format" do
    old_config = ::BootstrapForm::Datetimepicker.format
    ::BootstrapForm::Datetimepicker.format = "%Y-%m-%d"

    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    assert_equal expected, @builder.datetime_picker(:until)

    ::BootstrapForm::Datetimepicker.format = old_config
  end

  test "configure global :datetimepicker_format" do
    old_config = ::BootstrapForm::Datetimepicker.datetimepicker_format
    ::BootstrapForm::Datetimepicker.datetimepicker_format = "YYYY-MM-DD"

    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    assert_equal expected, @builder.datetime_picker(:until)

    ::BootstrapForm::Datetimepicker.datetimepicker_format = old_config
  end
end
