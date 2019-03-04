require File.expand_path("../Strategies/cache_wo_download", __dir__)

# A formula that installs the Instant Client Tools package.
class InstantclientTools12 < Formula
  desc "Oracle Instant Client Tools x64"
  homepage "http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html"
  hp = homepage

  url "http://download.oracle.com/otn/mac/instantclient/122010/instantclient-tools-macos.x64-12.2.0.1.0-2.zip",
      :using => (Class.new(CacheWoDownloadStrategy) do
                   define_method :homepage do
                     hp
                   end
                 end)
  sha256 "dfd2d9a2721d2e2a90d8053a8e4c9d0c9a68e8d47c9c99e1b80e8fa1c2edb99c"

  conflicts_with "instantclient-tools",
                 :because => "Differing versions of same formula"

  option "with-basiclite", "Depend on instantclient-basiclite instead of instantclient-basic."

  depends_on "instantclient-basic" if build.without?("basiclite")
  depends_on "instantclient-basiclite" if build.with?("basiclite")

  def install
    if HOMEBREW_PREFIX.to_s != "/usr/local"
      system DevelopmentTools.locate("install_name_tool"), "-add_rpath", HOMEBREW_PREFIX/"lib", "tools"
    end
    lib.install Dir["*.dylib"]
    bin.install %w[impdp expdp exp imp wrc sqlldr]
  end
end
