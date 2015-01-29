http://blog.bigbinary.com/2013/07/01/preload-vs-eager-load-vs-joins-vs-includes.html
 difference between “includes” and “joins” in ActiveRecord query?

:joins joins tables together in sql, :includes eager loads associations to avoid the n+1 problem (where one query is executed to retrieve the record and then one per association which is loaded).



Rails newcomers often believe explicitly joining the tables will solve the problem:

locations = Location.joins(:state).limit 10
=> [#<Location id: 1, name: "Ethyl & Tank", description: ...
     ...
     ...
    #<Location id: 10, name: "Atlas Arcade", ...
    ]
It however does not, because joins will also forego eager loading:

>> locations.first.state
State Load (0.2ms)  SELECT  `states`.* FROM `states`  WHERE `states`.`id` = 36 LIMIT 1
=> #<State id: 36, name: "Ohio", ...
Instead, if you know you’re going to want to retrieve associated data, you can eager load the data using the includes method:

@locations = Location.includes(:state).limit 10
This produces just two queries, even after iterating over all ten locations just as we did before:

SELECT  `locations`.* FROM `locations`  LIMIT 10
State Load (4.1ms)  SELECT `states`.* FROM `states`  WHERE `states`.`id` IN (36, 9)

This time, only two queries are executed. First, the ten locations are retrieved. Next, each location’s state record is retrieved by passing the list of state IDs into the second query. The state information is then attached to each location record, eliminating the need to perform the additional queries!







Naming Conventions

Ruby Naming Convention

Ruby uses the first character of the name to help it determine it’s intended use.

Local Variables
Lowercase letter followed by other characters, naming convention states that it is better to use underscores rather than camelBack for multiple word names, e.g. mileage, variable_xyz

Instance Variables
Instance variables are defined using the single "at" sign (@) followed by a name. It is suggested that a lowercase letter should be used after the @, e.g. @colour 

Instance Methods
Method names should start with a lowercase letter, and may be followed by digits, underscores, and letters, e.g. paint, close_the_door

Class Variables
Class variable names start with a double "at" sign (@@) and may be followed by digits, underscores, and letters, e.g. @@colour

Constant 
Constant names start with an uppercase letter followed by other characters. Constant objects are by convention named using all uppercase letters and underscores between words, e.g. THIS_IS_A_CONSTANT

Class and Module 
Class and module names starts with an uppercase letter, by convention they are named using MixedCase, e.g. module Encryption, class MixedCase

Global Variables
Starts with a dollar ($) sign followed by other characters, e.g. $global






Singleton is a design pattern that restricts instantiation of a class to only one instance that is globally available. It is useful when you need that instance to be accessible in different parts of the application, usually for logging functionality, communication with external systems, database access, etc.

There are few ways of implementing singleton pattern in Ruby:

Single Instance of a class


In Ruby, all objects have a singleton class (also known as metaclass). Objects inherit first from their singleton class invisibly, then from their explicit class. Ruby classes themselves have their own singleton classes since classes are objects as well. The class << idiom is simply Ruby's syntax for accessing the scope of an object's singleton class.

 class Person
   class << self
     # self in this scope is Person's singleton class
   end
 end

 person = Person.new
 person_singleton_class = class << person; self; end



Objects in Ruby only store the state. Its behaviour comes from its class definition.

Objects can also have methods that are independent of the parent class definition. They are called singleton methods and are stored on the metaclass of the object. The metaclass is typically invisible to the programmer.


class Sample
end

sam=Sample.new
def sam.test
  puts "Foo Foo Foo!"
end


sam.test
output
Foo Foo Foo

Sample.new.test
output

error
undifind_method test for #<Sample:>





Ruby method, Proc, and block confusion
Question 1: Blocks are not objects, they are syntactic structures; this is why they cannot be assigned to a variable. This is a privilege reserved for objects.

Question 2: Methods are not objects, so they cannot receive messages. Inversely, procs and lambdas are objects, so they cannot be invoked like methods, but must receive a message that tells them to return a value on the basis of the parameters passed with the message.

Procs and Lambdas are objects,  so they can receive the call message and be assigned to names. To summarize, it is being an object that makes procs and lambdas behave in ways you find odd. Methods and blocks are not objects and do not share that behavior.


 Block Examples

[1,2,3].each { |x| puts x*2 }   # block is in between the curly braces

[1,2,3].each do |x|
  puts x*2                    # block is everything between the do and end
end

# Proc Examples             
p = Proc.new { |x| puts x*2 }
[1,2,3].each(&p)              # The '&' tells ruby to turn the proc into a block 

proc = Proc.new { puts "Hello World" }
proc.call                     # The body of the Proc object gets executed when called

# Lambda Examples            
lam = lambda { |x| puts x*2 }
[1,2,3].each(&lam)

lam = lambda { puts "Hello World" }
lam.call

Differences

Procs are objects, blocks are not
At most one block can appear in an argument list
Lambdas check the number of arguments, while procs do not
Lambdas and procs treat the return’ keyword differently






delegate
delegate(*methods) public
Provides a delegate class method to easily expose contained objects’ public methods as your own.

Options
:to - Specifies the target object
:prefix - Prefixes the new method with the target name or a custom prefix
:allow_nil - if set to true, prevents a NoMethodError to be raised

The macro receives one or more method names (specified as symbols or strings) and the name of the target object via the :to option (also a symbol or string).

Delegation is particularly useful with Active Record associations:

class Greeter < ActiveRecord::Base
  def hello
    'hello'
  end

  def goodbye
    'goodbye'
  end
end

class Foo < ActiveRecord::Base
  belongs_to :greeter
  delegate :hello, to: :greeter
end

Foo.new.hello   # => "hello"
Foo.new.goodbye # => NoMethodError: undefined method `goodbye' for #<Foo:0x1af30c>
Multiple delegates to the same target are allowed:

class Foo < ActiveRecord::Base
  belongs_to :greeter
  delegate :hello, :goodbye, to: :greeter
end

Foo.new.goodbye # => "goodbye"

usage of attr_accessor in Rails

attr_accessor is a ruby code to (quickly) create setter and getter in a Class. That s all.

attr_accessor can be used for values you do not want to store in the database directly and that will only exist for the life of the object (e.g. passwords).

attr_reader can be used as one of several alternatives to doing something like this:

def instance_value
  "my value"
end

Ruby Overriding Methods

class A  
  def a  
    puts 'In class A'  
  end  
end  
  
class B < A  
  def a  
    puts 'In class B' 
     
  end  
end  
  
 B.new.a  or b = B.new----b.a

 "in class B"
 

The method a in class B overrides the method a in class A.

Usage of super

class A  
  def a  
    puts 'In class A'  
  end  
end  
  
class B < A  
  def a  
    puts 'In class B' '/n' 
    super 
  end  
end  
  
 B.new.a  or b = B.new----b.a

  "in class B" 
  "in class A"






class method vs instance method
Why class methods?
I often hear “Why to create an object when I can just call a class method?”. The reasoning behind that is quite obvious:
1) shorter code
2) less objects = less GC
3) stateless behavior and no need to initialization


class Foo
  def self.baz
     "class method"
  end
  def bar
     "instance method"
  end
end

Foo.baz = class method
Foo.new.bar= instance method





The Difference Between include and extend in Ruby

When we use include, the module s methods are added to the instances of the class.

Not available at the class level
Available at the instance level
Not available at the class level again


When we use extend, the modules methods are added to the class itself. 

Available at the class level.
Not available at the instance level.
Available at the class level.


module Foo
  def mmethod
    p "hi all"
  end
end

class Bar
  include Foo
end

class Baz
  extend Foo
end

Bar.new.Foo => hi all
Baz.Foo => hi all





require()

The require method does what include does in most other programming languages: run another file. 
It also tracks what you have required in the past and won t require the same file twice.
To run another file without this added functionality, you can use the load method.


What’s a Mixin?

A mixin can basically be thought of as a set of code that can be added to one or more classes to add 
additional capabilities without using inheritance. 
In Ruby, a mixin is code wrapped up in a module that a class can include or extend (more on those terms later). 
In fact, a single class can have many mixins.

# lib/my_module/foobar.rb
  module Foobar
    def foobar
      "Hello world!"
    end
  end

# app/models/my_model.rb
class MyModel < ActiveRecord::Base
  include Foobar
end


# rails console

MyModel.new.foobar
=> "Hello world!"

>> obj = MyModel.first
=> #<MyModel id: 1, ...>
>> obj.id
=> 1
>> obj.foobar
=> "Hello world!"

Symbols are immutable. Mutable objects can be changed after assignment while immutable objects can only be overwritten.
Ruby is quite unique in offering mutable Strings, which adds greatly to its expressiveness. 


irb(main):004:0> UsersController.superclass
=> ApplicationController
irb(main):004:0> UsersController.superclass.superclass
=> ActionController::Base
irb(main):006:0> UsersController.superclass.superclass.superclass
=> ActionController::Metal
irb(main):007:0> UsersController.superclass.superclass.superclass.superclass
=> AbstractController::Base
<oller.superclass.superclass.superclass.superclass.superclass
=> Object
<erclass.superclass.superclass.superclass.superclass.superclass
=> BasicObject
<erclass.superclass.superclass.superclass.superclass.superclass


Rake task

namespace :myrakename do
  desc "update value"
  task :price => :environment do
    our code
  end
end

namespace :myrakename do
  desc "my desc"
   task :mytaskname => :environment do 
    our code
  end
end

rake myrakename:mytaskname


Run in console below command
rake myrakename:price


Why Associations?
Why do we need associations between models? Because they make common operations simpler 
  and easier in your code. For example, consider a simple Rails application that includes a model 
  for customers and a model for orders. Each customer can have many orders. Without associations, 
    the model declarations would look like this:

has_one

A has_one association also sets up a one-to-one connection with another model, but with somewhat different semantics (and consequences). This association indicates that each instance of a model contains or possesses one instance of another model. For example, if each supplier in your application has only one account, youd declare the supplier model like this:

class User < ActiveRecord::Base
  has_one : userprofile
end
class Userprofile < ActiveRecord::Base
  belongs_to : user
end

has_many
A has_many association indicates a one-to-many connection with another model. You will often find this association on the "other side" of a belongs_to association. This association indicates that each instance of the model has zero or more instances of another model. For example, in an application containing customers and orders, the customer model could be declared like this:

class User < ActiveRecord::Base
  has_many : contacts
end
class Contacts < ActiveRecord::Base
  belongs_to : user
end



has_many :thought
A has_many :through association is often used to set up a many-to-many connection with another model. This association indicates that the declaring model can be matched with zero or more instances of another model by proceeding through a third model. For example, consider a medical practice where patients make appointments to see physicians. The relevant association declarations could look like this:

class Doctor < ActiveRecord::Base
  has_many : appoinments
  has_many : partitions, :thought => appoinments
end
class Appoinment < ActiveRecord::Base
  belongs_to : doctor
  belongs_to : doctor
end
class Patient < ActiveRecord::Base
  has_many : appoinments
  has_many : doctors, :thought => appoinments
end

polymorphic
A slightly more advanced twist on associations is the polymorphic association. With polymorphic associations, a model can belong to more than one other model, on a single association. For example, you might have a picture model that belongs to either an employee model or a product model. Here is how this could be declared:

class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
end
 
class Employee < ActiveRecord::Base
  has_many :pictures, as: :imageable
end
 
class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
end


 The has_and_belongs_to_many Association
A has_and_belongs_to_many association creates a direct many-to-many connection with another model, with no intervening model. For example, if your application includes assemblies and parts, with each assembly having many parts and each part appearing in many assemblies, you could declare the models this way:

class Assembly < ActiveRecord::Base
  has_and_belongs_to_many :parts
end
 
class Part < ActiveRecord::Base
  has_and_belongs_to_many :assemblies
end



my={"a"=>:100, "b"=>:200}

my.delete("a")



Memcache Steps:
MEMCACHE

To Start Memcache Server in Windows

Refer link - http://lang-asa.blogspot.in/2010/02/memcached-on-mac-and-windows-7.html

1)You can go to the folder of memcached installed and just double-click on "memcached.exe" at window explorer. It will run in port 11211.

2)Besides, in the command prompt window, for example, at c:\memcached, you can type in
memcached -vv -P /tmp/memcached.pid
It will display cache object.

In Application
1) gem 'dalli'
   gem 'memcachier'

2) In config/environments/development.rb or production.rb

 config.action_controller.perform_caching = true
 config.cache_store = :dalli_store, '127.0.0.1:11211',  {:namespace => "famtivity", :compress  => true}

Code to store & retrieve
dc = Dalli::Client.new("127.0.0.1:11211")

Eg:
 if (dc.fetch("activity_rows_for_user_#{cookies[:uid_usr]}").nil?)
  dc.set("activity_rows_for_user_#{cookies[:uid_usr]}",ActivityRow.select("Distinct(activities.category)").order("activities.category Asc").joins("left join activities on lower(activities.sub_category)=lower(activity_rows.row_type)").where("activity_rows.user_id = ?",cookies[:uid_usr]).group("activities.category").map(&:category))
end


S3

To check file exists in s3

s3 = AWS::S3.new(:access_key_id => 'AKIAICPKGEIENKWK7B6Q', :secret_access_key => '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')


s3 = AWS::S3.new(:access_key_id => S3_CONFIG['access_key_id'], :secret_access_key => S3_CONFIG['secret_access_key'])
#s="avatars/28823/original/10309757_231677627026549_5603829758102349226_n.jpg"
s = Activity.last.avatar.path

s3.buckets["famtivity/production"].objects[s].exists?


bucket = s3.buckets['bucket-name']
bucket.exists? #=> returns true/false


Need to change
In Live
config/s3.yml
bucket name : famtivity/production

what are the main differences between mysql and postgres?
are both open source database projects
postgress
Performance Slower 
vacuumdb -- garbage-collect and analyze a PostgreSQL database
Vacuum (cleanup) Yes 
large database storage
where condition with ''
case-sensivite
  However, quoted names are case-sensivite. SELECT * FROM "hello" is not equivalent to SELECT * FROM "HELLO"
join-query
  can join multiple table query easily

mysql
Performance Faster
Vacuum (cleanup) No
small database storage if we compare to postgress
where condition with ""
SSL support
join-query
  simple (table) query easily



Difference between Application server and Web Server
apache, nginx, IIS are web servers
mongrel, webrick, phusion passenger are app servers

App server is something which works with particular programming language and parses and executes the code
since mongrel and webrick can only work with rails, so they are app servers

Web servers are servers which can take the request from the browser.
Web servers normally works on port 80 though we can change the port in configuration 
since mongrel and webrick can take that request directly, so they can be thought of as web servers but web servers do have a lot of other functionality like request pipeline, load balancing etc.
App servers lack these functionalities.

About Mongrel server:
mongrel work as web as well as app server if you are talking about dev environment
but in production, mongrel alone can not work it will be too slow
so we need a web server in front of mongrel


protect_from_forgery

       protect_from_forgery

              |
    verify_authenticity_token

              |           yes
        verified_request?---->   execute request

              |no
    handle_unverified_request

              |
          reset_session



    TDD - Test Driven Development
    Is writing tests first, then writing code in your app to make the tests pass.
    1. group :development, :test do
        gem 'rspec-rails'
        gem 'factory_girl_rails'
    end
    2. rails generate rspec:install /*to generate spec folder*/
    3. $ rake db:migrate && rake db:test:prepare
    4. rake spec or rspec spec model/model_name_spec.rb
    5. rails generate rspec:models model_name
    6. syntax
        describe "Model/Controller" do
            context "define the functionality/env, start its description with "when" or "with"." do
                it "define the particular feature" do

                end
            end
        end
    7. before(:each) do

       end/* hook will be roll back at the end of the sample*/
    8. "let" the variable lazy loads only when it is used the first time in the test and get cached until that specific test is finished.
        describe '#type_id' do
             let(:resource) { FactoryGirl.create :device }
             let(:type)     { Type.find resource.type_id }

              it 'sets the type_id field' do
                expect(resource.type_id).to equal(type.id)
              end
        end


BDD - Behaviour Driven Development
    Tests from a "user story" perspective.It also a kind of automation testing
    1. group :test do
            gem 'cucumber-rails', :require => false
            # database_cleaner is not required, but highly recommended
              gem 'database_cleaner'
        end
    2.rails generate cucumber:install /*feature folder will be generated, .feature*/
    3.rake cucumber or bundle exec cucumber


    4.rake FEATURE=features/adding_products.feature cucumber
                or
    bundle exec cucumber features/users/signup.feature --require features

Example,
       Feature: Manage Articles
  In order to make a blog
  As an author
  I want to create and manage articles
  
  Scenario: Articles List
    Given I have articles titled Pizza, Breadsticks
    When I go to the list of articles
    Then I should see "Pizza"
    And I should see "Breadsticks"
  
  Scenario: Create Valid Article
    Given I have no articles
    And I am on the list of articles
    When I follow "New Article"
    And I fill in "Title" with "Spuds"
    And I fill in "Content" with "Delicious potato wedges!"
    And I press "Create"
    Then I should see "New article created."
    And I should see "Spuds"
    And I should see "Delicious potato wedges!"
    And I should have 1 article


  Feature: Addition
  In order to avoid silly mistakes
  As a math idiot 
  I want to be told the sum of two numbers

  Scenario Outline: Add two numbers
    Given I have entered <input_1> into the calculator
    And I have entered <input_2> into the calculator
    When I press <button>
    Then the result should be <output> on the screen

  Examples:
    | input_1 | input_2 | button | output |
    | 20      | 30      | add    | 50     |
    | 2       | 5       | add    | 7      |
    | 0       | 40      | add    | 40     |

    https://github.com/cucumber/cucumber/blob/master/examples/i18n/en/features/division.feature
    http://tacticalnuclearstrike.com/2009/05/starting-with-ruby-cucumber/

    # language: en
Feature: Division
  In order to avoid silly mistakes
  Cashiers must be able to calculate a fraction

  Scenario: Regular numbers
    * I have entered 3 into the calculator
    * I have entered 2 into the calculator
    * I press divide
    * the result should be 1.5 on the screen

foo.should be < 10
foo.should be <= 10
foo.should be > 10
foo.should be >= 10
# rather than:
lambda { do_something }.should raise_error(SomeError)


expect(foo).to be < 10
expect(foo).to be <= 10
expect(foo).to be > 10
expect(foo).to be >= 10
# ...you can do:
expect { something }.to raise_error(SomeError)



customer_profile_information={
  :profile=>{
    :merchant_customer_id => params[:name],
    :email => params[:email]
  }
}

create_profile=CIMGATEWAY.create_customer_profile(customer_profile_information)

billing_info={:first_name =>params[:name]}

creditcard=ActiveMerchant::Billing::CreditCard.new{
  :first_name=>
  :last_name=>
  :number =>
  :month =>
  :year =>
  :verification_value=>
  :type =>
}
payment_profile={
  :bill_to=>billing_info,
  :payment=>{
    :credit =>creditcard
  }
}
options = {
              :customer_profile_id => create_profile.authorization,
              :payment_profile => payment_profile
            }
pay_profile = CIMGATEWAY.create_customer_payment_profile(options)

@payment_profile_user = CIMGATEWAY.get_customer_payment_profile(:customer_profile_id=>create_profile.authorization, 
                        :customer_payment_profile_id=>pay_profile.params["customer_payment_profile_id"])
transaction = {:transaction => {
                  :type => :auth_capture,
                  :amount => "#{@usr_tran_amt}", #marget sell registrations
                  :customer_profile_id => create_profile.authorization,
                  :customer_payment_profile_id => pay_profile.params["customer_payment_profile_id"]
                }
              }
              response = CIMGATEWAY.create_customer_profile_transaction(transaction)
response = CIMGATEWAY.create_customer_profile_transaction(transaction)
              if !response.nil? && response.success?
              else #transaction response else part
                @failer_message= "#{response.message}" if !response.nil? && !response.message.nil?
                cookies[:card_msg]=@failer_message if !@failer_message.nil?
                @u_success=false
                #provider transaction details started stored user information after success or failure
                ProviderTransactionLog.create(:email_address=>@user.email_address,:amount=>@usr_tran_amt, :action_type=>"become_provider", :customer_payment_profile_id=>nil, :customer_profile_id=>nil, :inserted_date=>Time.now, :modified_date=>Time.now, :payment_date=>Time.now, :payment_message=>"#{response.message}", :payment_status=>"failure", :transaction_id=>nil, :user_id=>@user.user_id) if @user && @user.email_address
                #provider transaction details ended here
              end



Ramya fastream technology


Differ Class and Modules?
  -----------------------------------------------------------------------------------------------------------------------------
•               • class                     • module                          •
• ----------------------------------------------------------------------------------------------------------------------------
• instantiation • can be instantiated       • can *not* be instantiated       •
•------------------------------------------------------------------------------------------------------------------------------
• usage         • object creation           • mixin facility. provide         •
•               •                           •   a namespace.                  •
•------------------------------------------------------------------------------------------------------------------------------
• superclass    • module                    • object                          •
•------------------------------------------------------------------------------------------------------------------------------
• consists of   • methods, constants,       • methods, constants,             •
•               •   and variables           •   and classes                   •
•------------------------------------------------------------------------------------------------------------------------------
• methods       • class methods,            • module methods,                 •
•               •   instance methods        •   instance methods              •
•------------------------------------------------------------------------------------------------------------------------------
• inheritance   • inherits behavior and can • No inheritance                  •
•               •   be base for inheritance •                                 •
•-------------------------------------------------------------------------------------------------------------------------------
• inclusion     • cannot be included        • can be included in classes and  •
•               •                           •   modules by using the include  •
•               •                           •   command (includes all         •
•               •                           •   instance methods as instance  •
•               •                           •   methods in class/module)      •
•------------------------------------------------------------------------------------------------------------------------------
• extension     • can not extend with       • module can extend instance by   •
•               •   extend command          •   using extend command (extends •
•               •   (only with inheritance) •   given instance with singleton •
•               •                           •   methods from module) 
------------------------------------------------------------------------------------------------------------------------------


 Loading development environment (Rails 3.2.11)
[1] pry(main)> User.find 8100
 ←[1m←[36mUser Load (28.0ms)←[0m  ←[1mSELECT "users".* FROM "users" WHERE "user
s"."user_id" = $1 LIMIT 1←[0m  [["user_id", 8100]]
script/rails: No such file or directory - which less
=> '#<User user_name: "?sindhu'!", user_pwd: "12345678", email_address: "sindhuja
@i-waves.com", user_type: "P", user_created_date: "2014-03-06 14:44:47", user_ex
piry_date: "2014-04-05 14:44:47", account_active_status: true, user_id: 8100, us
er_flag: true, user_plan: "sell", fb_id: nil, sign_in_count: 177, last_sign_in:
"2014-12-08 09:18:47", show_card: true, manage_plan: "market_sell", new_email_ad
dress: "sindhuja1@i-waves.com", email_status: false, downgrade_plan: nil, user_s
tatus: "activate", latitude: 37.7652065, longitude: -122.2416355, is_partner: fa
lse, device_status: nil, user_password: "ODc2NTQzMjE=\n">
[2] pry(main)> u=_
=> #<User user_name: "?sindhu'!", user_pwd: "12345678", email_address: "sindhuja
@i-waves.com", user_type: "P", user_created_date: "2014-03-06 14:44:47", user_ex
piry_date: "2014-04-05 14:44:47", account_active_status: true, user_id: 8100, us
er_flag: true, user_plan: "sell", fb_id: nil, sign_in_count: 177, last_sign_in:
"2014-12-08 09:18:47", show_card: true, manage_plan: "market_sell", new_email_ad
dress: "sindhuja1@i-waves.com", email_status: false, downgrade_plan: nil, user_s
tatus: "activate", latitude: 37.7652065, longitude: -122.2416355, is_partner: fa
lse, device_status: nil, user_password: "ODc2NTQzMjE=\n">
[3] pry(main)> u.activities
=>   ←[1m←[35mActivity Load (25.0ms)←[0m  SELECT "activities".* FROM "activities
" WHERE "activities"."user_id" = 8100
[#<Activity activity_id: 28805, activity_name: "Sachin 100", category: "Sports",
sub_category: "Cricket", age_range: nil, leader: nil, price: nil, city: "Burlin
game", skill_level: "", schedule_mode: "Schedule", avatar_file_name: "india.jpg"
, avatar_content_type: "image/jpeg", avatar_updated_at: "2014-09-13 01:50:26", a'

Daya S <daya.naukri@gmail.com>
12/11/14

to me 
http://a4academics.com/tutorials/24-sql-tutorial/23-sql-like
https://confluence.atlassian.com/display/STASH/Basic+Git+commands
inheritance
class GF  
 def initialize  
  puts 'In GF class'  
 end  
 def gfmethod  
  puts 'GF method call'  
 end  
end  
  
# class F sub-class of GF  
class F < GF  
 def initialize  
  puts 'In F class'  
 end  
end  
  
# class S sub-class of F  
class S < F  
 def initialize  
  puts 'In S class'  
 end  
end  
son = S.new
son.gfmethod=> GF method call


Ruby Dynamic Methods

class A
    define_method :a do
      puts "hello"
    end

    define_method :greeting do |message|
      puts "hi i am #{message}"
    end
  end

  A.new.a #=> hello
  A.new.greeting 'Ram ram' #=> hi i am Ram ram



method_missing
method_missing is in part a safety net: It gives you a way to intercept unanswerable messages and handle them gracefully. See the example - p012zmm.rb below.

    class Dummy
      
    end

    Dummy.new.hello

    class: NoMethodError
    message: undefined method `hello' for #<Dummy:0x000000036539e0>
    backtrace: RubyMonk:6:in `<top (required)>


    class Dummy  
      def method_missing(m, *args, &block)  
        puts "There is no method called #{m} here -- please try again."  
      end  
    end  
    Dummy.new.hello  

The output is:

    >ruby p012zmm.rb  
    There is no method called hello here -- please try again.  
    >Exit code: 0  
Example for Mixin::
   module A
   def a1
     puts "one"
   end
   def a2
puts "two"
   end
end
module B
   def b1
puts "three"
   end
   def b2
puts "four"
   end
end

class Sample
include A
include B
   def s1
puts "five"
   end
end
facebook.com/
samp=Sample.new
samp.a1
samp.a2
samp.b1
samp.b2
samp.s1









 A member route will require an ID, because it acts on a member. A collection route doesnot because it acts on a collection of objects. Preview is an example of a member route, because it acts on (and displays) a single object. Search is an example of a collection route, because it acts on (and displays) a collection of objects

              URL                 Helper                      Description
----------------------------------------------------------------------------------------------------------------------------------
member          /photos/1/preview   preview_photo_path(photo)   Acts on a specific resource so required id (preview specific photo)
collection      /photos/search      search_photos_url           Acts on collection of resources(display all photos)


include vs join


 http://blog.bigbinary.com/2013/07/01/preload-vs-eager-load-vs-joins-vs-includes.html
 difference between “includes” and “joins” in ActiveRecord query?

:joins joins tables together in sql, :includes eager loads associations to avoid the n+1 problem (where one query is executed to retrieve the record and then one per association which is loaded).



Rails newcomers often believe explicitly joining the tables will solve the problem:

locations = Location.joins(:state).limit 10
=> [#<Location id: 1, name: "Ethyl & Tank", description: ...
     ...
     ...
    #<Location id: 10, name: "Atlas Arcade", ...
    ]
It however does not, because joins will also forego eager loading:

>> locations.first.state
State Load (0.2ms)  SELECT  `states`.* FROM `states`  WHERE `states`.`id` = 36 LIMIT 1
=> #<State id: 36, name: "Ohio", ...
Instead, if you know you’re going to want to retrieve associated data, you can eager load the data using the includes method:

@locations = Location.includes(:state).limit 10
This produces just two queries, even after iterating over all ten locations just as we did before:

SELECT  `locations`.* FROM `locations`  LIMIT 10
State Load (4.1ms)  SELECT `states`.* FROM `states`  WHERE `states`.`id` IN (36, 9)

This time, only two queries are executed. First, the ten locations are retrieved. Next, each location’s state record is retrieved by passing the list of state IDs into the second query. The state information is then attached to each location record, eliminating the need to perform the additional queries!


scope

class Zombie
  scope :rotting, -> { where(rotting: true) }
  scope :fresh, -> { where('age < ?', 25) }
  scope :recent, -> { order(:created_at, :desc) }
end
And you call

Zombie.rotting.fresh.recent.limit(3)




Naming Conventions

Ruby Naming Convention

Ruby uses the first character of the name to help it determine it’s intended use.

Local Variables
Lowercase letter followed by other characters, naming convention states that it is better to use underscores rather than camelBack for multiple word names, e.g. mileage, variable_xyz

Instance Variables
Instance variables are defined using the single "at" sign (@) followed by a name. It is suggested that a lowercase letter should be used after the @, e.g. @colour 

Instance Methods
Method names should start with a lowercase letter, and may be followed by digits, underscores, and letters, e.g. paint, close_the_door

Class Variables
Class variable names start with a double "at" sign (@@) and may be followed by digits, underscores, and letters, e.g. @@colour

Constant 
Constant names start with an uppercase letter followed by other characters. Constant objects are by convention named using all uppercase letters and underscores between words, e.g. THIS_IS_A_CONSTANT

Class and Module 
Class and module names starts with an uppercase letter, by convention they are named using MixedCase, e.g. module Encryption, class MixedCase

Global Variables
Starts with a dollar ($) sign followed by other characters, e.g. $global








ActiveMerchant
, avatar_content_type: "image/jpeg", avatar_updated_at: "2014-09-13 01:50:26", a'


7EDGE Commerce Pvt Ltd

Recruiter Name:Gopi Mohan
Email Address:hr@7edge.com
Website:http://7edge.com
Telephone:9686112499
Reference Id:7E-003

ruby-rails
javascript-jquery
html-css
oracle-mysql
ubuntu-windows
angular-node


D:\>rails new rails-club -d=postgress
Invalid value for --database option. Supported for preconfiguration are: mysql,
oracle, postgresql, sqlite3, frontbase, ibm_db, sqlserver, jdbcmysql, jdbcsqlite
3, jdbcpostgresql, jdbc.

D:\>rails new rails-club -d=postgresql


D:\rails-club>rails generate devise:install
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

Some setup you must do manually if you havenot yet:

  1. Ensure you have defined default url options in your environments files. Her
e
     is an example of default_url_options appropriate for a development environm
ent
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 300
0 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. If you are deploying on Heroku with Rails 3.2 only, you may want to set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the DB
     or load models when precompiling your assets.

  5. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================


How to configure Ruby on Rails with no database?
rails new myApp -O or rails new myApp --skip-activerecord


config/application.rb file you have the following line:

require 'rails/all'
Instead of load ALL, you must to load each library separatedly as follows:

require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"
Keep an eye the commented line, is where active_record is loaded. Then comment also the following lines:

#config/environments/development.rb
config.active_record.migration_error = :page_load

#config/environments/production.rb
config.active_record.dump_schema_after_migration = false

#spec/rails_helper.rb
ActiveRecord::Migration.maintain_test_schema!



Difference between Static and Dynamic Scaffolding?


dynamic scaffolding is when you give the line
scaffold :model_name
in your controller ruby will automatically generate all the appropriate data interfaces at runtime.

static scaffolding is when you give command to generate all the appropriate data
script/generate scaffold Post title:string content:text category_id:integer

Everything the dynamic scaffolding provided–is included, albeit as static content
All you need to do is migrate your DB.


What is request.xhr?
Sol: A request.xhr tells the controller that the new Ajax request has come, It always return TRUE or FALSE
If you're using :remote => true in your links or forms, you'd do:

respond_to do |format|
  format.js { #Do some stuff }
You can also check before the respond_to block by calling request.xhr?.

if request.xhr?
  # respond to Ajax request
else
  # respond to normal request
end


Filter
Filters are methods that are run before, after or “around” a controller action.

Filters are inherited, so if you set a filter on ApplicationController, it will be run on every controller in your application.

Before filters may halt the request cycle. A common before filter is one which requires that a user is logged in for an action to be run.

Before filters are run on requests before the request gets to the controller’s action. It can return a response itself and completely bypass the action.

The most common use of before filters is validating a user’s authentication before granting them access to the action designated to handle their request. I’ve also seen them used to load a resource from the database, check permissions on a resource, or manage redirects under other circumstances.

  before_filter :authenticate_user, :except=>[:provider_web_count,:data_entry,:search_event_index,:advanced_search, :advance_search, :landing_search, :search, :basic_search_count, :search_by_keyword, :activity_count_newsletter,:edit_update_sub_category,:add_participant], :only=>[:index]


After filters are run after the action completes. It can modify the response. Most of the time if something is done in an after filter, it can be done in the action itself, but if there is some logic to be run after running any of a set of actions, then an after filter is a good place to do it.

Generally, I’ve seen after and around filters used for logging.

Around filters may have logic before and after the action being run. It simply yields to the action in whatever place is necessary. Note that it doesn’t need to yield to the action and may run without doing so like a before filter.

You can use around filters for exception handling, setup and teardown, and a myriad of other cases.


a=[1,2,3]
b=[3,4,5]

a&b
innerjoin=3
leftouterjoin=123
rightouterjoin=345
outerjoin=12345

Git


add        Add file contents to the index
bisect     Find by binary search the change that introduced a bug
branch     List, create, or delete branches
checkout   Checkout a branch or paths to the working tree
clone      Clone a repository into a new directory
commit     Record changes to the repository
diff       Show changes between commits, commit and working tree, etc
fetch      Download objects and refs from another repository
grep       Print lines matching a pattern
init       Create an empty Git repository or reinitialize an existing one
log        Show commit logs
merge      Join two or more development histories together
mv         Move or rename a file, a directory, or a symlink
pull       Fetch from and integrate with another repository or a local branch
push       Update remote refs along with associated objects
rebase     Forward-port local commits to the updated upstream head
reset      Reset current HEAD to the specified state
rm         Remove files from the working tree and from the index
show       Show various types of objects
status     Show the working tree status
tag        Create, list, delete or verify a tag object signed with GPG




Table Name : Employee
EMPLOYEE_ID FIRST_NAME  LAST_NAME SALARY  JOINING_DATE          DEPARTMENT
1             John      Abraham   1000000 01-JAN-13 12.00.00 AM Banking
2             Michael   Clarke    800000  01-JAN-13 12.00.00 AM Insurance
3             Roy       Thomas    700000  01-FEB-13 12.00.00 AM Banking
4             Tom       Jose      600000  01-FEB-13 12.00.00 AM Insurance
5             Jerry     Pinto     650000  01-FEB-13 12.00.00 AM Insurance
6             Philip    Mathew    750000  01-JAN-13 12.00.00 AM Services
7             TestName1 123       650000  01-JAN-13 12.00.00 AM Services
8             TestName2 Lname%    600000  01-FEB-13 12.00.00 AM Insurance

Table Name : Incentives
EMPLOYEE_REF_ID INCENTIVE_DATE  INCENTIVE_AMOUNT
1                 01-FEB-13         5000
2                 01-FEB-13         3000
3                 01-FEB-13         4000
1                 01-JAN-13         4500
2                 01-JAN-13         3500

1. Get all employee details from the employee table
 Select * from employee 

2. Get First_Name,Last_Name from employee table
 Select first_name, Last_Name from employee 

3. Get First_Name from employee table using alias name “Employee Name”
 Select first_name Employee Name from employee 

4. Get First_Name from employee table in upper case
 Select upper(FIRST_NAME) from EMPLOYEE 

5. Get First_Name from employee table in lower case
  Select lower(FIRST_NAME) from EMPLOYEE

6. Get unique DEPARTMENT from employee table
select distinct DEPARTMENT from EMPLOYEE

Don t Miss - SQL and Database theory Interview Questions

7. Select first 3 characters of FIRST_NAME from EMPLOYEE

Oracle Equivalent of SQL Server SUBSTRING is SUBSTR, Query : select substr(FIRST_NAME,0,3) from employee

SQL Server Equivalent of Oracle SUBSTR is SUBSTRING, Query : select substring(FIRST_NAME,0,3) from employee

MySQL Server Equivalent of Oracle SUBSTR is SUBSTRING. In MySQL start position is 1, Query : select substring(FIRST_NAME,1,3) from employee
8. Get position of 'o' in name 'John' from employee table

Oracle Equivalent of SQL Server CHARINDEX is INSTR, Query : Select instr(FIRST_NAME,'o') from employee where first_name='John'

SQL Server Equivalent of Oracle INSTR is CHARINDEX, Query: Select CHARINDEX('o',FIRST_NAME,0) from employee where first_name='John'

MySQL Server Equivalent of Oracle INSTR is LOCATE, Query: Select LOCATE('o',FIRST_NAME) from employee where first_name='John'
9. Get FIRST_NAME from employee table after removing white spaces from right side

select RTRIM(FIRST_NAME) from employee
10. Get FIRST_NAME from employee table after removing white spaces from left side

select LTRIM(FIRST_NAME) from employee
11. Get length of FIRST_NAME from employee table

Oracle,MYSQL Equivalent of SQL Server Len is Length , Query :select length(FIRST_NAME) from employee

SQL Server Equivalent of Oracle,MYSQL Length is Len, Query :select len(FIRST_NAME) from employee
12. Get First_Name from employee table after replacing 'o' with '$'

select REPLACE(FIRST_NAME,'o','$') from employee
13. Get First_Name and Last_Name as single column from employee table separated by a '_'

Oracle Equivalent of MySQL concat is '||', Query : Select FIRST_NAME|| '_' ||LAST_NAME from EMPLOYEE

SQL Server Equivalent of MySQL concat is '+', Query : Select FIRST_NAME + '_' +LAST_NAME from EMPLOYEE

MySQL Equivalent of Oracle '||' is concat, Query : Select concat(FIRST_NAME,'_',LAST_NAME) from EMPLOYEE
14. Get FIRST_NAME ,Joining year,Joining Month and Joining Date from employee table

SQL Queries in Oracle, Select FIRST_NAME, to_char(joining_date,'YYYY') JoinYear , to_char(joining_date,'Mon'), to_char(joining_date,'dd') from EMPLOYEE

SQL Queries in SQL Server, select SUBSTRING (convert(varchar,joining_date,103),7,4) , SUBSTRING (convert(varchar,joining_date,100),1,3) , SUBSTRING (convert(varchar,joining_date,100),5,2) from EMPLOYEE

SQL Queries in MySQL, select year(joining_date),month(joining_date), DAY(joining_date) from EMPLOYEE