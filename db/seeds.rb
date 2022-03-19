Blog.delete_all
User.delete_all

alice = User.create!(email: 'alice@example.com', password: 'password', nickname: 'Alice')
alice.blogs.create!(title: 'こんにちは、アリスです', content: 'こんにちは。こんにちは。', secret: false)

bob = User.create!(email: 'bob@example.com', password: 'password', nickname: 'Bob')
bob.blogs.create!(title: 'こんにちは、ボブです', content: 'こんにちは。こんにちは。', secret: false)

carol = User.create!(email: 'carol@example.com', password: 'password', nickname: 'Carol')
carol.blogs.create!(title: 'こんにちは、キャロルです', content: 'こんにちは。こんにちは。', secret: false)
carol.blogs.create!(title: '秘密のブログです', content: 'これを見た人は死ぬ。', secret: true)