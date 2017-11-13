class Employee
  attr_reader :name, :title, :salary, :boss
  def initialize (name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end
  
  def bonus(multiplier)
    (self.salary) * multiplier
  end
  
end

class Manager < Employee
  attr_reader :employees
  def initialize (name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end
  
  def bonus(multiplier)
    self.sub_salary * multiplier
  end
  
  def sub_salary
    total_subsalary = 0
    @employees.each do |employee|
      if employee.is_a?(Manager)
        total_subsalary += employee.salary + employee.sub_salary
      else
        total_subsalary += employee.salary
      end
    end
    
    total_subsalary
  end
end