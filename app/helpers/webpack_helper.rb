module WebpackHelper

  def webpack_bundle_tag(bundle)
    src =
      if Rails.configuration.webpack[:use_manifest]
        manifest = Rails.configuration.webpack[:asset_manifest][bundle]
        bundle = manifest.instance_of?(Array) ? manifest[0] : manifest

        "#{Rails.configuration.action_controller.asset_host}/assets/#{bundle}"
      else
        "#{Rails.application.secrets.assets_url}/assets/#{bundle}_web_pack_bundle.js"
      end

    "<script src='#{src}' type='text/javascript'></script>".html_safe
  end

  def webpack_manifest_script
    return '' unless Rails.configuration.webpack[:use_manifest]
    javascript_tag "window.webpackBundleManifest = #{Rails.configuration.webpack[:common_manifest].to_json}"
  end

end
