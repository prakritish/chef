name "dev"
description "This is the development environment"
cookbook "apache","= 0.2.5"
override_attributes({
    "author" => {
        "name" => "Administrator"
    }
})
default_attributes({
    "author" => {
        "name" => "P Sen Eshore"
    }
})
