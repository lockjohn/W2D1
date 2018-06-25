class Employee
  attr_reader :name, :title, :salary, :boss
  
  def initialize(name, title, salary, boss=nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end
  
  def bonus(multiplier)
    salary * multiplier
  end
end 

class Manager < Employee
  
  def initialize(name, title, salary, boss=nil)
    super
    @employees = []
  end
  
  def add_employee(employee)
    @employees << employee 
  end
  
  def bonus(multiplier)
    total_salary_employees * multiplier
  end
  
  def total_salary_employees
    return 0 if @employees.empty?
    total = 0
    
    @employees.each do |employee|
      if employee.is_a?(Manager)
        # total += employee.salary
        total += employee.total_salary_employees
      end
      total += employee.salary
    end 
    total
  end
end 

if $PROGRAM_NAME == __FILE__
  
  emp1 = Employee.new("David","TA",10000)
  emp2 = Employee.new("Shawna","TA",12000)
  boss1 = Manager.new("Darren", "TA Manager", 78000)
  boss2 = Manager.new("Ned", "founder", 1000000)
  boss1.add_employee(emp1)
  boss1.add_employee(emp2)
  boss2.add_employee(boss1)
  puts boss2.total_salary_employees
  
end