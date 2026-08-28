terraform {
  
}

#Number list
variable "num_list" {
    type=list(number)
    default=[1,2,3,4,5]
}

#Object list of person
variable "person_list" {
    type=list (object({
        fname =string
        lname =string
    }))

    default = [{
        fname = "John"
        lname = "Doe"
    }, {
        fname = "Jane"
        lname = "Smith"
    }
    ]
}

variable "map_list" {
    type = map(number)
    default = {
        "one" = 1
        "two" = 2
        "three" = 3
    }
}

#Calculations

/*locals {
    mul = 2*8
    add = 2+2
    eq = 2 != 4
}

output "output_locals" {
    value = {
        mul = local.mul
        add = local.add
        eq = local.eq
    }
}
*/
locals {
    mul = 2*8
    add = 2+2
    eq = 2 != 4

    #double the list
double = [for num in var.num_list: num*2]
#Odd numbers from the list
odd = [for num in var.num_list : num if num%2 !=0]

#To get only fname from the person list
fname = [for person in var.person_list : person.fname]

#Work with map list
map_info = [for key, value in var.map_list : value*5]

double_map = {for key,value in var.map_list : key => value*2}

}

output "output_odd"{
 value = local.odd
}

output "output_fname" {
    value = local.fname
}

output "output_locals" {
    value = local.double
    }


output "output_map_info" {
    value = local.double_map
}

output "num_list_output" {
    value = var.num_list
}


output "person_list_output" {
    value = var.person_list
}

output "map_list_output" {
    value = var.map_list
}
