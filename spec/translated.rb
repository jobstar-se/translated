require "spec_helper"
require "logger"

describe ActsAsPublisher do
  before do
    @data = '{"id":6,"posted_at":1284536340,"updated_at":null,"deleted_at":null,"source":"www.arbetsformedlingen.se","source_url":"http://www.arbetsformedlingen.se/4.1799db4911df80d2fa9800024.html?id=5359949","title":"test","body":"Proffice konsulter \u00e4r specialister. Det \u00e4r det som har gjort att Proffice \u00e4r ett av Sveriges st\u00f6rsta och \u00e4ldsta bemanningsf\u00f6retag. Som Profficekonsult har du en trygg anst\u00e4llning med kollektivavtal i ett auktoriserat bemanningsf\u00f6retag. Du f\u00e5r m\u00f6jlighet att skaffa dig erfarenhet fr\u00e5n olika branscher och f\u00f6retag.\n\nV\u00e5ra uppdragsgivare st\u00e4ller h\u00f6ga krav p\u00e5 oss och vi st\u00e4ller h\u00f6ga krav p\u00e5 v\u00e5ra konsulter. Eftersom du har din dagliga arbetsplats ute hos v\u00e5ra kunder m\u00e5ste du vara skicklig p\u00e5 det du g\u00f6r, flexibel, sj\u00e4lvg\u00e5ende och social. Du gillar att st\u00e4ndigt st\u00e5 inf\u00f6r nya utmaningar och m\u00f6jligheter. Har du vad som kr\u00e4vs, kan du se fram emot ett stimulerande arbete och f\u00f6rm\u00e5ner som friskv\u00e5rdsbidrag, f\u00f6retagsh\u00e4lsov\u00e5rd, f\u00f6rs\u00e4kringar och rabatt p\u00e5 tr\u00e4ningskort. \n\nTill v\u00e5r uthyrningsversamhet s\u00f6ker vi dig som vill ha ett utvecklande och sp\u00e4nnande arbete som projektadministrat\u00f6r hos en kund inom statlig f\u00f6rvaltning. \n\nDu kommer att agera st\u00f6d till projektledaren. I dina arbetsuppgifter ing\u00e5r att f\u00f6rbereda Projektledarm\u00f6ten, skriva protokoll vid PL-m\u00f6ten, agera st\u00f6d till handl\u00e4ggarna och registrering i projektsystemet, administrera punktionsbrevl\u00e5dan, m\u00f6tesbokningar osv. \n\nVi s\u00f6ker dig som har dokumenterad erfarenhet av liknande arbetsuppgifter med goda referenser. Du ska vara  kunnig i n\u00e5got projektplaneringssystem och ha god datavana med stor kunskap i Officepaktetet. Goda engelskakunskaper i tal och skrift \u00e4r ett krav.\n\nVidare b\u00f6r du ha stor administrativ vana, vara stresst\u00e5lig och besitta f\u00f6rm\u00e5gan att ha ordning och reda. Du \u00e4r driven och m\u00e5ste kunna arbeta helt sj\u00e4lvst\u00e4ndigt och ta eget ansvar. Viktigt \u00e4r att du besitter en mycket god samarbetsf\u00f6rm\u00e5ga.","employer":{"name":"Proffice Sverige AB","national_id":null,"country":null,"email":null,"phone":null,"website":null,"mail_address":"Proffice Sverige AB\n- -","visit_address":null},"requirements":{"drivers_license":{"types":0},"own_car":false},"location_type":1,"locations":[],"categories":[],"seasons":null,"worktime":{"types":0,"text":"Visstid"},"duration":{"type":0,"text":null},"salary":{"type":1,"text":null},"num_positions":1,"application":{"email":null,"mail":"Proffice Sverige AB\n- -","phone":null,"url":"https://jobs.brassring.com/1053/asp/tg/cim_jobdetail.asp?jobid=382753&partnerid=20054&siteid=5036&Codes=Arbetsformedlingen","reference":null,"deadline":1285538400,"text":null},"first_day":null,"contacts":[{"formatted":"Sandstr\u00f6m, Hannah"}],"union_contacts":[],"keywords":[],"co_founder":null,"contractor":null}'
  end
  
  it "should add the acts_as_publisher method to a class" do
    Publisher.respond_to?(:acts_as_publisher).should be_true
  end

  it "should add the publish_data instance method to a class" do
    Publisher.new.should respond_to(:publish_data)
  end

  it "should add the publish_data instance method as an after_save callback" do
    p = Publisher.new
    p.should_receive(:publish_data)
    p.save
  end

  it "should raise error if the source_id option is not provided" do
    lambda { Publisher.acts_as_publisher("dummy", :foo => "bar") }.should raise_error("source_id option is required")
  end

  it "should validate data" do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    Publisher.valid_data?(@data).should == true
  end

  it "should prepare data" do
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    p = Publisher.new
    data = ActiveSupport::JSON.decode(p.prepare_data(ActiveSupport::JSON.decode(@data)))

    data["contacts"].should       be_an(Array)
    data["union_contacts"].should be_an(Array)
    data["categories"].should     be_an(Array)

    data["num_positions"].should  be_an(Integer)
    data["location_type"].should  be_an(Integer)
    data["seasons"].should        be_an(Integer)

    data["worktime"]["types"].should be_an(Integer)
  end
end
