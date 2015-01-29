http://rubylearning.com/satishtalim/tutorial.html
http://rubylearning.com/satishtalim/ruby_overriding_methods.html
http://www.tutorialspoint.com/ruby/ruby_modules.htm -->imporatant for modules and mixins concept
http://www.jvoegele.com/software/langcomp.html  --> even ruby is pure oops
http://www.railstips.org/blog/archives/2009/05/11/class-and-instance-methods-in-ruby/
http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
http://srikantmahapatra.wordpress.com/2013/11/07/ruby-on-rails-interview-questions-and-answers/ --->"good roor interview ques an answrs"
http://mobiwebits.blogspot.in/ ---> GIt informations

***********************OOPS COncept***********************************

Object:

This is the basic unit of object oriented programming. That is both data and function that operate on data are bundled as a unit called as object.
Class:

When you define a class, you define a blueprint for an object. This does not actually define any data, but it does define what the class name means, that is, what an object of the class will consist of and what operations can be performed on such an object.
Abstraction:

Data abstraction refers to, providing only essential information to the outside word and hiding their background details, i.e., to represent the needed information in program without presenting the details.

For example, a database system hides certain details of how data is stored and created and maintained. Similar way, C++ classes provides different methods to the outside world without giving internal detail about those methods and data.
Encapsulation:

Encapsulation is placing the data and the functions that work on that data in the same place. While working with procedural languages, it is not always clear which functions work on which variables but object-oriented programming provides you framework to place the data and the relevant functions together in the same object.
Inheritance:

One of the most useful aspects of object-oriented programming is code reusability. As the name suggests Inheritance is the process of forming a new class from an existing class that is from the existing class called as base class, new class is formed called as derived class.

This is a very important concept of object-oriented programming since this feature helps to reduce the code size.
Polymorphism:

The ability to use an operator or function in different ways in other words giving different meaning or functions to the operators or functions is called polymorphism. Poly refers to many. That is a single function or an operator functioning in many ways different upon the usage is called polymorphism.
Overloading:

The concept of overloading is also a branch of polymorphism. When the exiting operator or function is made to operate on new data type, it is said to be overloaded.

*******************END********************************************************

Class methods are methods that are called on a class and instance methods are methods that are called on an instance of a class*********


*******Modules are a way of grouping together methods, classes, and constants. Modules give you two major benefits.

    Modules provide a namespace and prevent name clashes.

    Modules implement the mixin facility.**********
*************Mixins give you a wonderfully controlled way of adding functionality to classes. However, their true power comes out when the code in the mixin starts to interact with code in the class that uses it.******************
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

********************************************************
Public methods enforce no access control -- they can be called in any scope.

Protected methods are only accessible to other objects of the same class.

Private methods are only accessible within the context of the current object.
*********************************************************************************************
Ruby autoload?
defines a mapping from a module (by symbol or string) to a filename.

If you want to autoload all the files in a directory, then you need a way to know what module your file represents without opening it.

You can achieve this by following a naming convention. Assuming you encapsulate your convention in a method filename_to_module, then all you need to do is iterate recursively over the folder and call autoload(filename_to_module(filename), filename)
**********************************************************
Metaprogramming?
Metaprogramming is the writing of computer programs that write or manipulate other programs (or themselves) as their data, or that do part of the work at compile time that would otherwise be done at runtime. In many cases, this allows programmers to get more done in the same amount of time as they would take to write all the code manually, or it gives programs greater flexibility to efficiently handle new situations without recompilation. Or, more simply put: Metaprogramming is writing code that writes code during runtime to make your life easier

Metaprogramming in Ruby is writing code that manipulates language constructs (like classes, modules, and instance variables) at runtime. It is even possible to enter new Ruby code at runtime and execute the new code without restarting the program.

With define_method, we can iterate over each method name and reduce the duplication like so:

    # With define_method:
    %w(user email food).each do |meth|
      define_method(meth) { @data[meth.to_sym] }
    end

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

***
Blocks are not objects, but they can be converted into objects of class Proc. This can be done by calling the lambda method of the class Object. A block created with lambda acts like a Ruby method. If you don't specify the right number of arguments, you can't call the block.

    prc = lambda {"hello"}can only inh
# Block Examples

[1,2,3].each { |x| puts x*2 }   # block is in between the curly braces

[1,2,3].each do |x|
  puts x*2                    # block is everything between the do and end
end
  

***Proc objects are blocks of code that have been bound to a set of local variables. The class Proc has a method call that invokes the block*****

******The require() method is quite similar to load(), but itâ€™s meant for a different purpose. You use load() to execute code, and you use require() to import libraries.*************
******* Include is for adding methods to an instance of a class and extend is for adding class methods****************
*************************************
alias_method can be redefined if need be. (it's defined in the Module class.)

alias's behavior changes depending on its scope and can be quite unpredictable at times.

Verdict: Use alias_method - it gives you a ton more flexibility.
************************************
****************************************
Ruby send method ?
innvokes the method identified by symbol, passing it any arguments specified. You can use __send__ if the name send clashes with an existing method in obj. When the method is identified by a string, the string is converted to a symbol.

class Klass
  def hello(*args)
    "Hello " + args.join(' ')
  end
end
k = Klass.new
k.send :hello, "gentle", "readers"   #=> "Hello gentle readers"

**********************************************
why ror?
There are lot of advantages of using ruby on rails. 
1. DRY Principal( Donâ€™t Repeat Yourself): It is a principle of software development aimed at reducing repetition of code. â€œEvery piece of code must have a single, unambiguous representation within a systemâ€

2. Convention over Configuration: Most web development framework for .NET or Java force you to write pages of configuration code. If you follow suggested naming conventions, Rails doesnâ€™t need much configuration.
******************************************
What is Rails?

1. Rails is a extremely productive web-application framework written in Ruby lanThe require() method is quite similar to load(), but itâ€™s meant for a different purpose. You use load() to execute code, and you use require() to import libraries.guage by David Hansson.

2. Rails are an open source Ruby framework for developing database-backend web applications.

3. Rails include everything needed to create a database-driven web application using the Model-View-Controller (MVC) pattern.
****************************************
What are the various components of Rail?

1. Action Pack: Action Pack is a single gem that contains Action Controller, Action View and Action Dispatch. The â€œVCâ€ part of â€œMVCâ€ .

Action Controller: Action Controller is the component that manages the controllers in a Rails application. The Action Controller framework processes incoming requests to a Rails application, extracts parameters, and dispatches them to the intended action.

Services provided by Action Controller include session management, template rendering, and redirect management.

Action View:  Action View manages the views of your Rails application. It can create both HTML and XML output by default.

Action View manages rendering templates, including nested and partial templates, and includes built-in AJAX support.

Action Dispatch: Action Dispatch handles routmethodsing of web requests and dispatches them as you want, either to your application or any other Rack application. Rack applications are a more advanced topic and are covered in a separate guide called Rails on Rack.

2. Action Mailer: Action Mailer is a framework for building e-mail services. You can use Action Mailer to receive and process incoming email and send simple plain text or complex multipart emails based on flexible templates.

3. Active Model: Active Model provides a defined interface between the Action Pack gem services and Object Relationship Mapping gems such as Active Record. Active Model allows Rails to utilize other ORM frameworks in place of Active Record if your application needs this.

4. Active Record: Active Record are like Object Relational Mapping (ORM), where classes are mapped to table, objects are mapped to columns and object attributes are mapped to data in the table.

5. Active Resource: Active Resource provides a framework for managing the connection between business objects and RESTful web services. It implements a way to map web-based resources to local objects with CRUD semantics.

6. Active Support: Active Support is an extensive collection of utility classes and standard Ruby library extensions that are used in Rails, both by the core code and by your applications.
***************************************
3. Explain about RESTful Architecture.

RESTful: REST stands for Representational State Transfer. REST is an architecture for designing both web applications and application programming interfaces (APIâ€™s), thatâ€™s uses HTTP.

RESTful interface means clean URLs, less code, CRUD interface. CRUD means Create-READ-UPDATE-DESTROY. In REST, they add 2 new verbs, i.e, PUT, DELETE.
*************************************
 What is ORM in Rails?

ORM tends for Object-Relationship-Model, where Classes are mapped to table in the database, and Objects are directly mapped to the rows in the table
************************************
What is MVC? and how it Works?

MVC tends for Model-View-Controller, used by many languages like PHP, Perl, Python etc. The flow goes like this:

Request first comes to the controller, controller finds and appropriate view and interacts with model, model interacts with your database and send the response to controller then controller based on the response give the output parameter to view.
***************************************
How many types of callbacks available in ROR?
before_validation,before_validation_on_create,validate_on_create,after_validation,after_validation_on_create,before_save,before_create,after_create
 after_save
**************************************
 What are the servers supported by ruby on rails?

RoR was generally preferred over WEBrick server at the time of writing, but it can also be run by:
Lighttpd (pronounced â€˜lightyâ€™) is an open-source web server more optimized for speed-critical environments.
Abyss Web Server- is a compact web server available for windows, Mac osX and Linux operating system.
Apache and nginx
************************************************
 What do you mean by Naming Convention in Rails.

Variables: Variables are named where all letters are lowercase and words are separated by underscores. E.g: total, order_amount.

Class and Module: Classes and modules uses MixedCase and have no underscores, each word starts with a uppercase letter. Eg: InvoiceItem

Database Table: Table name have all lowercase letters and underscores between words, also all table names to be plural. Eg: invoice_items, orders etc

Model: The model is named using the class naming convention of unbroken MixedCase and always the singular of the table name.

For eg: table name is might be orders, the model name would be Order. Rails will then look for the class definition in a file called order.rb in /app/model directory. If the model class name has multiple capitalized words, the table name is assumed to have underscores between these words.

Controller: controller  class names are pluralized, such that OrdersController would be the controller class for the orders table. Rails will then look for the class definition in a file called orders_controlles.rb in the /app/controller directory
*****************************************************
How you run your Rails application without creating databases?

You can run your application by uncommenting the line in environment.rb
path=> rootpath conf/environment.rb
config.frameworks- = [action_web_service, :action_mailer, :active_record
******************************************************
How to use sql db or mysql db without defining it in the database.yml?

You can use ActiveRecord anywhere
require â€œrubygemsâ€
require â€œactive_recordâ€
ActiveRecord::Base.establish_connection({
               :adapter=> â€˜postgresqlâ€™, :user=>â€™fooâ€™, :password=> â€˜abcâ€™, :database=>â€™whateverâ€™})
*****************************************************
GET and POST Method?

GET is basically for just getting (retrieving) data, whereas POST may involve anything, like storing or updating data, or ordering a product, or sending E-mai
*********************************************************
differ unittest&functionaltest
Unit Test - testing an individual unit, such as a method (function) in a class, with all dependencies mocked up.

Functional Test - AKA Integration Test, testing a slice of functionality in a system. This will test many methods and may interact with dependencies like Databases or Web Services.
******************************************************
What is the difference between Symbol and String?
The symbol in Ruby on rails act the same way as the string but the difference is in their behaviors that are opposite to each other
Strings are considered as mutable objects. Whereas, symbols, belongs to the category of immutable
In Ruby, a string is mutable, whereas a symbol is immutable. That means that only one copy of a symbol needs to be created. Thus, if you have

x = :my_str
y = :my_str

:my_str will only be created once, and x and y point to the same area of memory. On the other hand, if you have

x = "my_str"
y = "my_str"

a string containing my_str will be created twice, and x and y will point to different instances.

As a result, symbols are often used as the equivalent to enums in Ruby, as well as keys to a dictionary (hash).
********************************************************
Ruby variables?

    Local Variables: Local variables are the variables that are defined in a method. Local variables are not available outside the method. You will see more detail about method in subsequent chapter. Local variables begin with a lowercase letter or _.

    Instance Variables: Instance variables are available across methods for any particular instance or object. That means that instance variables change from object to object. Instance variables are preceded by the at sign (@) followed by the variable name.

    Class Variables: Class variables are available across different objects. A class variable belongs to the class and is a characteristic of a class. They are preceded by the sign @@ and are followed by the variable name.

    Global Variables: Class variables are not available across classes. If you want to have a single variable, which is available across classes, you need to define a global variable. The global variables are always preceded by the dollar sign ($).
**********************************************************
Difference between Application Server and Web Server
Ans:apache, nginx, IIS are web servers
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
******************************************************************
Difference between TDD & BDD
1). BDD focuses on specifying what will happen next. where as TDD focuses on setting up a set of conditions and then looking at the output.

2). BDD specifies behaviours while TDD specifies outcomes.

3). BDD can be layered, while outcomes(TDD) cannot.

4). TDD is for testing and we canâ€™t perform Design process, Requirements capturing and Behavior specification in TDD, but these can be possible in BDD.

5). BDD is mainly used as a communication tool. its main goal is write executable specifications which can be understood by the domain experts.

6). the main difference between BDD and TDD is wording. as these are important for communicating your intend.


**********************JAVASCRIPT QUES AND ANSWERS***********************************
Javascript

Javascript is a programming language.  It comes standard with most modern web browsers.  It is also the same language that is used in Flash (where itâ€™s called ActionScript), and can be used to write scripts in Photoshop, Illustrator, etc.  In the context of a web browser, it is often used to manipulate the DOM (see below).
jQuery

jQuery is a Javascript library, meaning that it is essentially a collection of functions written in Javascript that can be used to make the programmerâ€™s job easier.  Common tasks that take more lines of code with traditional Javascript can be executed with calls to the jQuery functions.  There are several other Javascript libraries out there that fill the same need.  For one reason or another, jQuery seems to be the most popular library of the day.
The DOM

The Document Object Model (DOM), is just that â€“ a model for representing and interacting with an XML, XHTML, or HTML document.  Our HTML documents are created by typing tags in plain text, and the DOM is a way to access the tags and the structure of the â€œtag treeâ€ . 

For example, instead of using regular expressions to find the text that represents a tag with a specific ID attribute, we can ask the DOM which of its tags has that ID.  Javascript is not part of the DOM or vice-versa, but Javascript in the browser does include some intelligence about the DOM â€“ for example, the getElementById() function. 

One of the main advantages of jQuery is the extra intelligence it has regarding the DOM.  With it, you access and create DOM elements (tags) by using the many selectors and traversing operations it offers.
************************************************************************************




class A  
  def a  
    puts 'In class A'  
  end  
end  
  
class B < A  
  def a  
    puts 'In class B' 
    super 
  end  
end  



task intw



JOIN
Return rows when there is at least one match in both tables. SQL query to join above tables are as given below

select * from employee a join salary b on a.employee_id = b.employee_id_ref

Left JOIN

Return all rows from the left table, even if there are no matches in the right table. SQL query to left join above tables are as given below.

select * from employee a left join salary b on a.employee_id = b.employee_id_ref


Right JOIN

Return all rows from the right table, even if there are no matches in the left table. SQL query to right join above tables are as given below

select * from employee a right join salary b on a.employee_id = b.employee_id_ref”


Full JOIN

Return rows when there is a match in one of the tables. SQL query to full join above tables are as given below

select * from employee a full join salary b on a.employee_id = b.employee_id_ref




daya
ramar
jana
jafer
kumar
ramar

To fetch all names containing letter a, following SQL query is used.

select * from employee where employee_name like '%a%'

daya
ramar

select * from employee where employee_name like 'J%'
jana
jafer


To fetch all names ending with letter y, following SQL query is used.

select * from employee where employee_name like '%r'
kumar
ramar

SQL Distinct Clause

SELECT DISTINCT City FROM Customers;




<script type="text/javascript">

function usershow(id)
{

$.ajax({
  type:"GET",
  url:"usershow",
  data: {"id":id,"name":name},
  data: $("#form_id").serialize();
  datatype: "script",
  success: function(data){},
  error: function(){
    sorry
  } 
});

}

</script>

Get checkbox value in jQuery

$("input[type='checkbox']").val();
Or if you have set a class or id for it, you can:

$('#check_id').val();
$('.check_class').val();
Also you can check whether it is checked or not like:

if ($('#check_id').is(":checked"))
{
  // it is checked
}



namespace :admin do
  resources :posts, :comments
end


A member route will require an ID, because it acts on a member. A collection route doesn't because it acts on a collection of objects. Preview is an example of a member route, because it acts on (and displays) a single object. Search is an example of a collection route, because it acts on (and displays) a collection of objects.'

:member creates path with pattern /:controller/:id/:your_method

:collection creates path with the pattern /:controller/:your_method

match '/eventlist' => 'provider#index'

GET    /foo            # FooController#index
GET    /foo/:id        # FooController#show
GET    /foo/new        # FooController#new
POST   /foo            # FooController#create
GET    /foo/:id/edit   # FooController#edit
PUT    /foo/:id        # FooController#update
DELETE /foo/:id        # FooController#destroy


Easily swap two variables’ values
In Ruby, you can easily swap values of two variables without the need for a temporary third variable:

x,y = y,x
This is called ‘Parallel Assignment’.
Can’t believe it? I had to test it myself, too:

$ irb
>> x = 5
=> 5
>> y = 10
=> 10
>> x,y = y,x
=> [10, 5]
>> x
=> 10
>> y
=> 5


Swap two elements of an array in Ruby

array = [4, 5, 6, 7]

array[0], array[3] = array[3], array[0]

array # => [7, 5, 6, 4]

array.max    7

array.sort[-2]





mysql> SELECT * FROM Employee;
+--------+----------+---------+--------+
| emp_id | emp_name | dept_id | salary |
+--------+----------+---------+--------+
| 1      | James    | 10      |   2000 |
| 2      | Jack     | 10      |   4000 |
| 3      | Henry    | 11      |   6000 |
| 4      | Tom      | 11      |   8000 |
+--------+----------+---------+--------+
4 rows IN SET (0.00 sec)

SELECT max(salary) FROM Employee WHERE salary NOT IN (SELECT max(salary) FROM Employee);
+-------------+
| max(salary) |
+-------------+
|        6000 |
+-------------+
1 row IN SET (0.00 sec)


SELECT max(salary) FROM Employee WHERE salary < (SELECT max(salary) FROM Employee);
+-------------+
| max(salary) |
+-------------+
|        6000 |
+-------------+
1 row IN SET (0.00 sec)


SELECT max(salary) FROM Users where <(SELECT max(salary) FROM User)



installation

pf 

How to change Rails 3 server default port in develoment?


change port number
rails s -p 8080



I like to append the following to config/boot.rb:

require 'rails/commands/server'

module Rails
  class Server
    alias :default_options_alias :default_options
    def default_options
      default_options_alias.merge!(:Port => 3333)
    end    
  end
end


First - do not edit anything in your gem path! It will influence all projects, and you will have a lot problems later...

In your project edit script/rails this way:

#!/usr/bin/env ruby
# This command will automatically be run when you run "rails" with Rails 3 gems installed from the root of your application.

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)

# THIS IS NEW:
require "rails/commands/server"
module Rails
  class Server
    def default_options
      super.merge({
        :Port        => 10524,
        :environment => (ENV['RAILS_ENV'] || "development").dup,
        :daemonize   => false,
        :debugger    => false,
        :pid         => File.expand_path("tmp/pids/server.pid"),
        :config      => File.expand_path("config.ru")
      })
    end
  end
end
# END OF CHANGE
require 'rails/commands'


installation
The below steps for installing Ruby in windows OS:

1.Download and Install ruby packages as 1.8.7,1.9.3,2.0.0

2.Download Dev Kit for required packages as 1.8.7,1.9.3,2.0.0
  
3.Go to :C:/Ruby/193/bin

4.Extract your devkit

5.Run the below commands

  ruby dk.rb
  ruby dk.rb init
  ruby dk.rb review
  ruby dk.rb install

6.Type ruby -v
Ruby installed successfully

7.run "gem install rails" for rails installation



tasklist 

show all runing list