require 'test_helper'
require 'faker'

class Rest::SessionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @email = Faker::Internet.free_email
    @user_agent = Faker::Internet.user_agent
    @url = "http://localhost:3001/rest/verify/#{@email}"
    @request_headers =  {
                          'Content-Type' => 'application/json',
                          'User-Agent' => @user_agent
                        }
    @test_image_base64 = "/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAPAAA/+4AJkFkb2JlAGTAAAAAAQMAFQQDBgoNAAACHwAAAokAAAMoAAAD8P/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggLDAoKCwoKDBAMDAwMDAwQDA4PEA8ODBMTFBQTExwbGxscHx8fHx8fHx8fHwEHBwcNDA0YEBAYGhURFRofHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8f/8IAEQgAHgAeAwERAAIRAQMRAf/EAKgAAQACAwAAAAAAAAAAAAAAAAUDBgECBAEAAwEBAAAAAAAAAAAAAAAAAQIDBAAQAAIBBAICAwAAAAAAAAAAAAECAwAQEQQSBSBBIjITEQABAwIEAwkAAAAAAAAAAAABABECIUFREiIDMWETEPCRoTJCUqIjEgEAAAAAAAAAAAAAAAAAAABAEwEAAgIBBAIDAQAAAAAAAAABABEhMUEQUWFxgZEgscHR/9oADAMBAAIRAxEAAAGjKkgsurh1hoA1HSir1m+eEoxLQpOtW14cqbTKoh7ivn//2gAIAQEAAQUCmd+WvryTPs9XLFEpapfv1scjxzx7Z11Vv2f5N1LtEdksgV2zxj5aB4w7AyAi8f/aAAgBAgABBQK2bm3qj4i3/9oACAEDAAEFAhWKxYULe6HgM01v/9oACAECAgY/Agf/2gAIAQMCBj8CB//aAAgBAQEGPwJsxQgJajZCQL/IBSGY9z2TOyf0e1CyhGUtWcxJfwU43dvNHC6lut+fB8F1Dt887llLcv6vs6Lzpfip9MZ9r3PRGpG1hVlLXRueK//aAAgBAQMBPyHHfsYgJ0W13WIkZsZrxOFwGbb0j3+4la1W3sD/ACL3aypYlhmMddfiQoDA2icXJxTpfEMurQtbeDU8h/vSG6PLAP8AEDK/mKd6upaM9nL8KKmrfR2PE//aAAgBAgMBPyGL+Db8msRiQdP/2gAIAQMDAT8hEOjWejTrDrvMFj+ET0//2gAMAwEAAhEDEQAAEGwb8eAcLv/aAAgBAQMBPxAKyFYO0eZcZUFUDY4CZojq0HKvZt9xSqUWAvB74hA1BLHAhDkCEAG0oW5y2LjoZaAGhrhvzM58zfN4/v8AsoSoq4KqMUXc3sV7tx4gjlCZo1z2ISrmYLKEjGRrS4x1MLUh1knY+IgzekXOLJT1CDegXrNs/wD/2gAIAQIDAT8QJQQzg4lRsDmHLxFizC4avEHmBe4F4SBif//aAAgBAwMBPxA2XMRUdUdMJFR/aXQ4jQR3eZUwQxq/hKWmLnU//9k="
    @request_body = { image: @test_image_base64 }.to_json
    @authorized_response_body = { message: "OK" }.to_json
    @unauthorized_response_body = { message: "No Autorizado" }.to_json
  end

  test "should return status 401" do

    stub_request(:post, @url)
      .with(
        body: @request_body,
        headers: @request_headers
      )
      .to_return(
        status: [401, "No Autorizado"],
        body: @unauthorized_response_body,
        headers: {})

    post rest_login_url, params: {
                            email: @email, image: @test_image_base64
                          }.to_json,
                          headers: @request_headers

    assert_response 401
    assert_equal @unauthorized_response_body, @response.body
  end

  test "should return status 200" do

    stub_request(:post, @url)
      .with(
        body: @request_body,
        headers: @request_headers
      )
      .to_return(
        status: [200, "OK"],
        body: @authorized_response_body,
        headers: {})

    post rest_login_url, params: {
                            email: @email, image: @test_image_base64
                          }.to_json,
                          headers: @request_headers

    assert_response 200
    assert_equal @authorized_response_body, @response.body
  end
end
