# README

## Bulsup
・Bulsupは7項目を入力・選択するだけで増量のために1日に摂取すべきカロリーを自動計算し、<br >
&nbsp;&nbsp;&nbsp;摂取カロリーを満たした食事内容を提案してくれるアプリです。  
・摂取カロリーを計算してくれるアプリはあるが、<br >
&nbsp;&nbsp;&nbsp;摂取カロリーの値から摂取カロリーを満たす具体的な食事内容を提案してくれるアプリはなかったため開発しました。<br >
&nbsp;&nbsp;&nbsp;筋トレ初心者など増量が必要な方の手助けになれば幸いです。  
・BulsupはBulk up Supportの略称です。

## URL
http://43.207.212.104/ <br >
トップページの「ゲストとしてログイン」から会員登録をせずにログインできます。

## 使用技術
・Ruby 3.2.2  
・Ruby on Rails 6.1.7  
・React  
・ChatGpt API
・Mysql 8.0  
・Nginx  
・Unicorn  
・Aws  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- VPC  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- EC2  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- RDS   
・Docker

## 機能一覧
・ユーザー登録、ログイン、ログアウト、パスワード再設定機能(devise)    
・会員情報編集機能  
・消費カロリー・摂取カロリー計算機能  
・食事内容提案機能(ChatGpt API、Ajax)  

## テスト
・Rspec  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 単体テスト(model)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 機能テスト(request)  
