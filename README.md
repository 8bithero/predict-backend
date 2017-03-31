# Fitzdares
__Task A:__ Result prediction API
* Written with Ruby & Rails or Elixir & Phoenix
* Assume this is a part of a bigger project rather than as a code kata
* Supports JSON
* Exposes a single API end point to provide the prediction function as detailed below.

__Prediction:__
Given two team names, return probability (two digits) that the first team defeats the second one. The probability is worked out by finding the number of times each of the characters in the word DEFEATS appears in the team names. This should result in your first number made of 7 or more digits. To obtain the next number in the series you should add each sequential pair of digits together to form the next number like so:

1 2 3 1

\\/ \\/ \\/

3 5 4

Repeat this process until you are left with only 2 digits.

__Example:__
Virtus Pro & Ninjas in Pyjamas

D E F E A T S

0 0 0 0 3 1 3

...

000344

00378

031015

34116

7527

1279

3916

12107

3317

648

1012

113

...

24%

---

# Optional App Configuration
The app supports setting the Prediction word as an environment variable (This has been done for demonstration purposes). Since we are not using a DB, the advantage of this approach is that the variable can be configured using tools like Puppet. This way we would not need to redeploy our entire app just to change the value.

Optional enviroment variables can be set from the usual `config/enviroments/`
```
config.x.prediction_word = ENV['PREDICTION_WORD'] || 'DEFEATS'`
```

---

# Running the app
From the apps route directory run the following command to start the rails server:
```
$ rails s
```

The app responds to JSON and requests can be made via a browser or apps like CURL or POSTMAN.
_Note_: The `&` needs to be sent as `%26` as the literal value is currently not supported by the app.

__Example call:__
```
localhost:3000/prediction?teams="Virtus Pro %26 Ninjas in Pyjamas"
```

__Result:__
```
{
  "score": "24"
}
```

### Error handling
The app handles the basic error case of not including an `&` in the string.

__Example call:__
```
localhost:3000/prediction?teams="No ampersand here"
```

__Result:__
```
{
  "errors": {
    "format": [
      "Invalid team name format. Example format: \"First Name & Second Name\""
    ]
  }
}
```

In the above case, all formatting related errors could be added to the array, and any other type of errors would be added to the errors hash.

---

# Testing the app
From the projects route directory, run the following command to run all tests:
```
$ rspec
```

* Controller specs have been removed in favour of request specs
* Due to time constraints request specs also validate the structure of the returned JSON. In a real world scenario these should be tested in the view.
* Admittedly the app may be slightly over tested :p

---
# Justification of design decisions
### Service results pattern
You will notice the prediction service returns either a ServiceValueResult object or a ServiceErrorResult object. The advantage of having services return these result objects (instead of a value) means all services can be handled in the same way regardless of what task they are performing.

For the given task this approach is DEFINITELY OVERKILL. The pattern was a personal experiment and has only been included for demonstration purposes. It would not be used in a similar real world scenario. In retrospect the naming of the objects is also confusing and it would have been better to return a single ServiceResult object (instead of the Errors and Value objects).

### Error Hash
The Hash class has also been extended to create ErrorHash.
The ErrorHash gives you an easy and homogeneous way of collecting errors and passing them to the service result.
Once again, for such a small app this could be considered overkill and is here primarily for demonstration purposes.
