search(:groups, "*:*").each do |data|
    group data["id"] do
        members data["members"]
    end
end
