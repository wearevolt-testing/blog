require 'ffaker'

10.times.each do
  user = User.create!(
                        email: FFaker::Internet.email,
                        nickname: FFaker::Name.unique.name,
                        password: '111111',
                        password_confirmation: '111111'
                      )

  puts "User #{user.nickname} was created"

  10.times.each do
    post = Post.create!(
                          title: FFaker::Lorem.sentence,
                          body: FFaker::Lorem.paragraph,
                          published_at: Time.now - rand(3).years,
                          author: user
    )

    puts "Post #{post.title} was created"

    5.times.each do |n|
      post = Comment.create!(
          body: FFaker::Lorem.paragraph,
          published_at: Time.now - rand(3).years,
          author: user,
          commentable: post
      )

      puts "Comment # #{n+1} was created"
    end
  end
end
