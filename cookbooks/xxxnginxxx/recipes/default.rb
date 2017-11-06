include_recipe 'chef_nginx::default'


edit_resource(:template, 'C:\\Users\\Serhii_Panchenko\\chef-repo\\cookbooks\\chef_nginx\\templates\\default\\default-site.erb') do
	source 'loadbalancer.erb'
	cookbook 'xxxnginxxx'
end





