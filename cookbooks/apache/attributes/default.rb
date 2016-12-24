default["apache"]["sites"]["prakritish3"] = { "site_title" => "Prakritish3 website coming soon", "port" => 80, "domain" => "prakritish3.mylabserver.com" }
default["apache"]["sites"]["prakritish3b"] = { "site_title" => "Prakritish3b website coming soon:", "port" => 8080, "domain" => "praritish3b.mylabserver.com" }
default["apache"]["sites"]["prakritish4"] = { "site_title" => "Prakritish4 website coming soon", "port" => 80, "domain" => "prakritish4.mylabserver.com" }

case node["platform"]
when "centos"
    default["apache2"]["package"] = "httpd"
when "ubuntu"
    default["apache2"]["package"] = "apache2"
end
