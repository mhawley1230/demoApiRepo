'use strict';


/**
 * Allows users to get employees
 *
 * uUID String UUID number of employee
 * first_name String Users first name (optional)
 * last_name String Users last name (optional)
 * returns inline_response_200
 **/
exports.usersGET = function(uUID,first_name,last_name) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = {
  "join_date" : "1511884800",
  "last_name" : "Stevens",
  "UUID" : "3110-78-8832",
  "first_name" : "James",
  "email" : "j_stevens@sb.com",
  "status" : 200
};
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}


/**
 * Allows user to submit user data to the DB
 *
 * employee Employee_1 Creates a new employee in DB (optional)
 * returns inline_response_200_2
 **/
exports.usersPOST = function(employee) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = {
  "join_date" : "1512655200",
  "last_name" : "Richards",
  "UUID" : "3110-79-8833",
  "first_name" : "Peter",
  "email" : "p_richards@sb.com",
  "status" : 200
};
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}


/**
 * Allows users to update user data to the DB
 *
 * employee Employee Updates an employee in DB (optional)
 * returns inline_response_200_1
 **/
exports.usersPUT = function(employee) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = {
  "message" : "resource successfully added",
  "status" : 200
};
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

