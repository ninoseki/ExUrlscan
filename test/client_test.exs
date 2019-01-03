defmodule UrlscanTest.ClientTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExUrlscan.V1.Client
  alias ExUrlscan.Configuration

  setup do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
    api_key = Configuration.config()[:api_key]
    ExVCR.Config.filter_sensitive_data(api_key, "YOUR_API_KEY")
    :ok
  end

  test "#result/1" do
    use_cassette "result" do
      {:ok, json} = Client.result("33db13c5-ad2d-4fa2-8f92-fcb8c9528755")
      task = Map.get(json, "task")
      uuid = Map.get(task, "uuid")
      assert uuid == "33db13c5-ad2d-4fa2-8f92-fcb8c9528755"
    end
  end

  test "#search/1" do
    use_cassette "search" do
      {:ok, json} = Client.search(q: "domain:urlscan.io")
      results = Map.get(json, "results")
      assert length(results) > 0
    end
  end

  test "#scan/1" do
    use_cassette "scan" do
      {:ok, json} = Client.scan("http://neverssl.com")
      url = Map.get(json, "url")
      assert url == "http://neverssl.com"
    end
  end

  test "#scan/2" do
    use_cassette "scan_with_options" do
      {:ok, json} = Client.scan("http://neverssl.com", public: "off")
      url = Map.get(json, "url")
      assert url == "http://neverssl.com"
    end
  end
end
