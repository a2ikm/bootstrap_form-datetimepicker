require "spec_helper"

describe BootstrapForm::Datetimepicker do
  before { @schedule = Schedule.new }
  let(:builder) { BootstrapForm::FormBuilder.new(:schedule, @schedule, self, {}) }
  let(:horizontal_builder) { BootstrapForm::FormBuilder.new(:schedule, @schedule, self, { layout: :horizontal }) }

  it "should render datetimepicker correctly in normal layout" do
    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD HH:mm:ss">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    expect(builder.datetime_picker(:until)).to eq expected
  end

  it "should render datetimepicker correctly in horizontal layout" do
    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label col-sm-2" for="schedule_until">Until</label>
  <div class="col-sm-10">
    <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD HH:mm:ss">
      <input class="form-control" id="schedule_until" name="schedule[until]" type="text" />
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar">
        </span>
      </span>
    </div>
  </div>
</div>
    HTML

    expect(horizontal_builder.datetime_picker(:until)).to eq expected
  end

  it "should render wrapping div with datetimepicker_class option" do
    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label col-sm-2" for="schedule_until">Until</label>
  <div class="col-sm-10">
    <div class="custom-datetimepicker-class input-group date" data-date-format="YYYY-MM-DD HH:mm:ss">
      <input class="form-control" id="schedule_until" name="schedule[until]" type="text" />
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar">
        </span>
      </span>
    </div>
  </div>
</div>
    HTML

    expect(horizontal_builder.datetime_picker(:until, :datetimepicker_class => "custom-datetimepicker-class")).to eq expected
  end

  it "should render with initial value" do
    @schedule.until = Time.now

    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD HH:mm:ss">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" value="#{@schedule.until.to_s}" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    expect(builder.datetime_picker(:until)).to eq expected
  end

  it "should put value attribute in format specified with format_name option" do
    @schedule.until = Time.now
    Time::DATE_FORMATS[:custom] = "%Y-%m-%d %H:%M:%S"

    expected = <<-HTML.gsub(/ *\n */, "")
<div class="form-group">
  <label class="control-label" for="schedule_until">Until</label>
  <div class="bootstrap_form-datetimepicker input-group date" data-date-format="YYYY-MM-DD HH:mm:ss">
    <input class="form-control" id="schedule_until" name="schedule[until]" type="text" value="#{@schedule.until.to_s(:custom)}" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar">
      </span>
    </span>
  </div>
</div>
    HTML

    expect(builder.datetime_picker(:until, :format_name => :custom)).to eq expected
  end
end
