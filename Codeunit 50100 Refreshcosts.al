codeunit 50100 "Cost API"
{
    procedure Refresh();
    var
        Cost: Record Cost;
        ResponseMessage: HttpResponseMessage;
        JsonObj: JsonObject;
        JsonArr: JsonArray;
        JsonTkn: JsonToken;
        i: Integer;
        JsonText: Text;
        RequestContent: HttpContent;
    begin
        Cost.DeleteAll;
        JsonText := ExecuteAPI('Get', '', RequestContent, false);
        
        JsonObj.ReadFrom(JsonText);
        if JsonObj.SelectToken('value',JsonTkn) then begin
            JsonArr := JsonTkn.AsArray;
            foreach JsonTkn in JsonArr do
                Insertcosts(JsonTkn);
        end else
            Insertcosts(JsonTkn);
    end;

    procedure ExecuteFunction(FunctionName:Text);
    var
        RequestContent: HttpContent;
        RequestHeaders: HttpHeaders;
    begin
        RequestContent.WriteFrom('{ "inParam": "Hello World" }');
        RequestContent.GetHeaders(RequestHeaders);
        RequestHeaders.Remove('Content-Type');
        RequestHeaders.Add('Content-Type', 'application/json');

        ExecuteAPI('Post', FunctionName,
          RequestContent,true);
    end;

    local procedure ExecuteAPI(Method: Text;FunctionName: Text;Content: HttpContent;HasRequestContent: Boolean) JsonText : Text;
    var
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        Client: HttpClient;
        Headers: HttpHeaders;
        TempBlob: Record TempBlob temporary;
        APISetup: Record "API Setup";
        AuthText: Text;
        Uri:Text;
    begin
        APISetup.get('OPS');
        APISetup.TestField("API URL");
        APISetup.TestField("User Name");
        APISetup.TestField(Password);
        APISetup.TestField("Company Id");
        Uri := APISetup."API URL" + FunctionName;
                
        RequestMessage.Method := Method;
        RequestMessage.SetRequestUri(Uri);
        RequestMessage.GetHeaders(Headers);
        
        AuthText := StrSubstNo('%1:%2',APISetup."User Name",APISetup.Password);
        TempBlob.WriteAsText(AuthText,TextEncoding::Windows);
        Headers.Add('Authorization',StrSubstNo('Basic %1',TempBlob.ToBase64String()));
        
        if HasRequestContent then begin
            RequestMessage.Content := Content;
        end;

        Client.Send(RequestMessage,ResponseMessage);

        if not ResponseMessage.IsSuccessStatusCode then
            Error('The web service returned an error message:\' +
                    'Status code: %1' +
                    'Description: %2',
                    ResponseMessage.HttpStatusCode,
                    ResponseMessage.ReasonPhrase);
                    
        ResponseMessage.Content.ReadAs(JsonText);

    end;
    local procedure Insertcosts(JsonToken: JsonToken);
    var
        Cost: Record Cost;
        JsonObj: JsonObject;
    begin
        JsonObj := JsonToken.AsObject;
        
        Cost.init;
        
        Cost."entryNo" := GetJsonToken(JsonObj,'entryNo').AsValue.AsInteger;
        Cost."id" := COPYSTR(GetJsonToken(JsonObj,'id').AsValue.AsText,1,250);
        Cost."tripNo" := COPYSTR(GetJsonToken(JsonObj,'tripNo').AsValue.AsText,1,250);
        Cost."costExecutiondate" := GetJsonToken(JsonObj,'costExecutionDate').AsValue.AsDate;
        Cost."type" := COPYSTR(GetJsonToken(JsonObj,'type').AsValue.AsText,1,250);
        Cost."costNo" := COPYSTR(GetJsonToken(JsonObj,'costNo').AsValue.AsText,1,250);
        Cost."Description" := COPYSTR(GetJsonToken(JsonObj,'description').AsValue.AsText,1,250);
        Cost."quantity" := GetJsonToken(JsonObj,'quantity').AsValue.AsDecimal;
        Cost."amount" := GetJsonToken(JsonObj,'amount').AsValue.AsDecimal;
        Cost."shortcutDimension1Code" := COPYSTR(GetJsonToken(JsonObj,'shortcutDimension1Code').AsValue.AsText,1,250);
        Cost."truckNo" := COPYSTR(GetJsonToken(JsonObj,'truckNo').AsValue.AsText,1,250);
        Cost."truckDescription" := COPYSTR(GetJsonToken(JsonObj,'truckDescription').AsValue.AsText,1,250);
        Cost."driverNo" := COPYSTR(GetJsonToken(JsonObj,'driverNo').AsValue.AsText,1,250);
        Cost."driverName" := COPYSTR(GetJsonToken(JsonObj,'driverName').AsValue.AsText,1,250);
        Cost."trailerNo" := COPYSTR(GetJsonToken(JsonObj,'trailerNo').AsValue.AsText,1,250);
        Cost."trailerDescription" := COPYSTR(GetJsonToken(JsonObj,'trailerDescription').AsValue.AsText,1,250);
        Cost."transportOrderNo" := COPYSTR(GetJsonToken(JsonObj,'transportOrderNo').AsValue.AsText,1,250);
        Cost."transportOrderLineNo" := GetJsonToken(JsonObj,'transportOrderLineNo').AsValue.AsInteger;
        Cost."irrNo" := GetJsonToken(JsonObj,'irrNo').AsValue.AsInteger;
        Cost."legNo" := GetJsonToken(JsonObj,'legNo').AsValue.AsInteger;
        Cost."unitOfMeasureCode" := COPYSTR(GetJsonToken(JsonObj,'unitOfMeasureCode').AsValue.AsText,1,250);
        Cost."payToVendorNo" := COPYSTR(GetJsonToken(JsonObj,'payToVendorNo').AsValue.AsText,1,250);
        Cost."vendorName" := COPYSTR(GetJsonToken(JsonObj,'vendorName').AsValue.AsText,1,250);
        Cost.Validate("currencyCode", COPYSTR(GetJsonToken(JsonObj,'currencyCode').AsValue.AsText,1,250));
        Cost.company := CopyStr(GetJsonToken(JsonObj,'company').AsValue.AsText,1,30);
        Cost.open := GetJsonToken(JsonObj,'open').AsValue.AsBoolean;
        Cost.genProdPostingGroup := GetJsonToken(JsonObj,'genProdPostingGroup').AsValue.AsCode;
        Cost.unitCost := GetJsonToken(JsonObj,'unitCost').AsValue.AsDecimal;
        Cost.Insert;
    end;
    local procedure GetJsonToken(JsonObj: JsonObject; TokenKey: Text) JsonTkn: JsonToken;
    begin
        if not JsonObj.Get(TokenKey,JsonTkn) then
            Error('Could not find a token with key %1',TokenKey);
    end;

}
