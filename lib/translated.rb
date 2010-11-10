class Translated

  WSDL_URI = 'http://mymemory.translated.net/otms/?wsdl'

  def initialize(api_key)
    @api_key = api_key
    @client = Savon::Client.new(WSDL_URI)
  end

  def get(source, source_lang, target_lang, subject = "All", mt = 1)
    response = @client.otms_get do |soap|
      soap.xml = <<-EOS
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"> 
  <SOAP-ENV:Body> 
    <otmsGet xmlns="http://tempuri.org/"> 
      <key xmlns:SOAPSDK1="http://tempuri.org/">#{@api_key}</key> 
      <q xmlns:SOAPSDK2="http://tempuri.org/"> 
        <source>#{source}</source> 
        <source_lang>#{source_lang}</source_lang> 
        <subject>#{subject}</subject> 
        <target_lang>#{target_lang}</target_lang> 
        <mt>#{mt}</mt> 
      </q> 
    </otmsGet> 
  </SOAP-ENV:Body> 
</SOAP-ENV:Envelope> 
EOS
    end

    result = response.to_hash[:otms_get_response][:otms_get_result]

    raise RuntimeError, "Gateway error" if result[:success] == "0"

    matches = result[:matches][:match]
    matches.kind_of?(Array) ? matches : [ matches ]
  end
end
