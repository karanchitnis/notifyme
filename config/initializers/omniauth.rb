Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '168698036642860', '33516449145ee1185354303b7ea96bf5', {client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
  provider :twitter, 'kPbcgggl5V8pJXfvCuUVA', 'j6Lw1YoBr3id1DHzLB3p7TGIGsySd9CjIegkOu7SU', {client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
  provider :google_oauth2, "142932211105", "xa1hbMizE1y8ZNIwY5RMXDol", {client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
end

Koala::HTTPService.http_options[:ssl] = {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}
Koala.http_service.http_options = {:ssl => { :ca_path => "/etc/ssl/certs" }}