module FakewebHelpers
  # Make sure nothing gets out (IMPORTANT)
  # FakeWeb.allow_net_connect = false

  # Convenience methods for stubbing URLs to fixtures
  def stub_get(url, args = {})
    FakeWeb.register_uri(:get, url, args)
  end

  def stub_post(url, args = {})
    FakeWeb.register_uri(:post, url, args)
  end

  def stub_any(url, args = {})
    FakeWeb.register_uri(:any, url, args)
  end
end

World(FakewebHelpers)
