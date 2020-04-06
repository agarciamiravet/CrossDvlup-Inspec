title 'Check http headers'

site = "https://www.pasionporlosbits.com" 

control 'web_http_status' do
    title 'Check if site returns code http 200'
    describe http(site) do
        its('status') { should cmp '200'}
    end
end

control 'web_check_httpsecureheaders' do
    title 'Check secure headers like x-frame-options and set-cookie'
     describe http(site) do
         its ('headers.X-XSS-Protection') { should cmp '1; mode=block'}
         its ('headers.Set-Cookie') { should match /HttpOnly/}
         its ('headers.X-Frame-Options') { should cmp 'DENY' }
         its ('headers.X-Content-Type-Options') { should cmp 'nosniff' }
         its ('headers.Strict-Transport-Security') { should cmp 'max-age=31536000' }
         its ('headers.Server') { should eq nil }
     end
 end

 control 'web_check_csp_policies' do 
    title 'Check csp policies'
    describe http(site) do
        its ('headers.Content-Security-Policy') { should match /script-src 'self'/ }
        its ('headers.Content-Security-Policy') { should match /style-src 'self'/ }
        its ('headers.Content-Security-Policy') { should match /font-src 'self'/ }
        its ('headers.Content-Security-Policy') { should match /img-src 'self'/ }
        its ('headers.Content-Security-Policy') { should match /form-action 'self'/ }
        its ('headers.Content-Security-Policy') { should match /frame-ancestors 'self'/ }
        its ('headers.Content-Security-Policy') { should match /block-all-mixed-content/ }        
    end
 end