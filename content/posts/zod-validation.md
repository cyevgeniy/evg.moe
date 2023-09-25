---
title: "Vue: input data validation with zod"
description: "Using zod js library for form validation"
date: 2023-05-25T22:52:02+03:00
draft: false
toc: true
---

This post consists from two parts - the first one is
a small introduction to the zod library, and the second
one is about how we can use it for form validation in Vue.

<!--more-->

## Source code

[Download final source code](/vue-zod-validation.zip).

## Zod

[Zod](https://zod.dev) is a javascript library for data validation.
It has pretty small bundle size, works with typescript and
javascript, and it's easy to start with.



### Philosophy

Zod is a library for data validation - it doesn't work with
UI elements - only with plain js data. It means that you can
use zod on a server side, as well as on a client. It also means
that you can't use it for form validation until form's input
controls are not bounded to a javascript data structure(s).

### Object validation

To validate something with zod, you first need to create a
_validation schema_ - a special object that will parse
the data.

```
import {z} from "zod";

const userSchema = z.object({
	name: z.string(),
	age: z.number()
	});

userSchema.parse({name: "Username"});
```

All fields are required by default. To make some property optional,
use `optional()`:

```
import {z} from "zod";

const userSchema = z.object({
	name: z.string(),
	age: z.number().optional() // number | undefined
	});

userSchema.parse({name: "Username"});
```

`Parse` method returns a **deep copy** of input variable or throws an error if
a value doesn't pass validation. As an alternative, we can use `safeParse` method, which returns
either a copy of input variable or an error. A little remark about return types - in zod, there's
a `Input` type and a `Output` type. Usually, they're the same. But since zod supports data
[transformation](https://zod.dev/?id=transform),
the output type [may differ from the input type](https://zod.dev/?id=type-inference).

### Schema reusability

We can re-use already defined schemas:

```
import {z} from "zod";

const contactsSchema = z.object({
	email: z.string().email(),
	phone: z.string().max(50)
	});

const userSchema = z.object({
	name: z.string().max(50),
	contacts: contactsSchema
	});
```

Here, we've reused `contactsSchema` inside `userSchema` declaration.
In general, it's a good idea to decompose complex schemas into smaller ones -
it's the same thing as creating functions to handle complex logic.

### Refinements

[Refinements](https://zod.dev/?id=refine) in zod allow you to create your own validation logic.
Documentation is pretty clear on how to use refinements, so I won't copy examples here.

## Using zod for input validation in Vue

### Form

We will validate a form with personal user information. It will contain
these fields:

-   Username (required, max 50 characters)
-   Email (required)
-   Real name (optional, max 100 characters)
-   City (required, max 100 characters)
-   Work email (by default has the same value as `Email`)

In this form, the field with work email will be hidden by default, and
a "Same as the main email" checkbox will hide/show it.
If it's visible, it's required. If it's not visible, it's not required, because
it has the same value as the "Email" field.

First, we need to create a new Vue project:

```
npm create vue@3
```

We don't need any libraries except typescript, so don't forget to
include it in the project during creation.

So, here our starting point - a form with input fields, where each
input is bounded to a data model, and a "Submit" button. When a user clicks
the button, state of the form is showing up. There're no any error checks yet, but
we'll add them later.

```
<script setup lang="ts">
<script setup lang="ts">
import {shallowReactive} from "vue";

interface PersonalInfo {
  username?: string;
  email?: string;
  name?: string;
  city?: string;
  workEmail?: string;

  /**
   * True if workEmail is the same as main email
   */
  sameEmail: boolean;
}


const formData = shallowReactive<FormData>({
  sameEmail: true
})

function onSubmit() {
  alert(JSON.stringify(formData, null, 2));
}

</script>

<template>
<div class="container">
  <h1>Personal info</h1>
    <div class="input">
      <label for="username"> Username </label>
      <input name="username" v-model="formData.username"/>
    </div>
    <div class="input" >
      <label for="email"> Email </label>
      <input name="email" v-model="formData.email"/>
    </div>
    <div class="input">
      <label for="name"> Real name </label>
      <input name="name" v-model="formData.name"/>
    </div>
    <div class="input">
      <label for="city"> City  </label>
      <input name="city" v-model="formData.city"/>
    </div>
    <div>
      <label for="sameEmail"> Work email is the same as the main  </label>
      <input type="checkbox" name="sameEmail" v-model="formData.sameEmail" />
    </div>
    <div v-if="!formData.sameEmail" class="input">
      <label for="workemail"> Work email  </label>
      <input name="workemail" v-model="formData.workEmail"/>
    </div>

    <button @click="onSubmit"> Submit </button>
  </div>
</template>

<style scoped>
.input {
display: flex;
  gap: 0.3rem;
  flex-direction: column;
}
.container {
  display: flex;
  gap: 1rem;
  flex-direction: column;
}

button {
  font-size: 1.5rem;
  margin-top: 1.5rem;
  background-color: blue;
}
</style>

</script>

<template>
<div class="container">
  <h1>Personal info</h1>
    <div class="input">
      <label for="username"> Username </label>
      <input name="username"/>
    </div>
    <div class="input" >
      <label for="email"> Email </label>
      <input name="email" />
    </div>
    <div class="input">
      <label for="name"> Real name </label>
      <input name="name" />
    </div>
    <div class="input">
      <label for="city"> City  </label>
      <input name="city" />
    </div>
    <div class="input">
      <label for="workemail"> Work email  </label>
      <input name="workemail" />
    </div>

    <button> Submit </button>
  </div>
</template>

<style scoped>
.input {
display: flex;
  gap: 0.3rem;
  flex-direction: column;
}
.container {
  display: flex;
  gap: 1rem;
  flex-direction: column;
}

button {
  font-size: 1.5rem;
  margin-top: 1.5rem;
  background-color: blue;
}
</style>
```

Now our form looks like this:

![Form screenshot](/img/vue-zod-1.png)

And when a user clicks the "Submit" button, we show
the value of the `formData` variable:

![Form screenshot](/img/vue-zod-2.png)

### Display error messages

Our form now accepts all possible string values, without any
restrictions. It's time to add validation and tell the user
what fields were filled are incorrect. Let's add error messages to the
input fields (you can check out `input` css class in the full source code
at the end of the post):

```
<div class="input">
  <label for="city"> City  </label>
  <input name="city" v-model="formData.city"/>
  <div class="error"> city error </div>
</div>
```

Now each of our fields has an error label:

![Form screen](/img/vue-zod-3.png)

What we want now is to validate all fields and show corresponding error messages for
all invalid fields when a user clicks
the "Submit" button. First of all, we need a validation schema:

```
const personalSchema = z.object({
  username: z.string().max(50),
  email: z.string().email(),
  name: z.string().max(100),
  city: z.string().max(100),
  sameEmail: z.boolean(),
  workEmail: z.string().optional()
}).refine((val) => {
  const emailRegex =
  /^([A-Z0-9_+-]+\.?)*[A-Z0-9_+-]@([A-Z0-9][A-Z0-9\-]*\.)+[A-Z]{2,}$/i;

  return val.sameEmail || emailRegex.test(val.workEmail)
}, {message: "Invalid email", path: ["workEmail"]})
```

It doesn't look very simple for such task, though. Let's take a closer
look at what we have here.

```
username: z.string().max(50),
email: z.string().email(),
name: z.string().max(100),
city: z.string().max(100),
sameEmail: z.boolean(),
```

These lines describe rules for our fields, and everything is
straightforward here.

```
...
workEmail: z.string().optional()
}).refine((val) => {
  const emailRegex =
  /^([A-Z0-9_+-]+\.?)*[A-Z0-9_+-]@([A-Z0-9][A-Z0-9\-]*\.)+[A-Z]{2,}$/i;

  return val.sameEmail || (val.workEmail ? emailRegex.test(val.workEmail) : false)
}, {message: "Invalid email", path: ["workEmail"]})
```

This is the root of our schema's ugliness. The `workEmail` field
is optional when the `sameEmail` flag is true, and when this
flag is false, `workEmail` should be validated as an email field.
In zod, for validations that require a context (and we need one here, because
the result of validation relies on **another field's value**), the [`refine()`](https://zod.dev/?id=refine)
method is used. Its first argument is a function that accepts the whole schema
as a parameter, and _the truthiness of its result_ leads
to passing the validation. The second parameter is settings - we set the error message
and and the error's path.

This line returns `true` if the `sameFlag` is true, or returns the result
of email validation, which is done by regular expression. I've grabbed this regex
from zod's source code, by the way:

```
return val.sameEmail || (val.workEmail ? emailRegex.test(val.workEmail) : false)
```

### Run validation

First of all, we need zod itself:

```
npm i zod
```

We want to show error messages only when a user presses the "Submit" button.
After that, any changes in input fields should re-launch validation.
Also, we need a convenient way to get error messages. First, we need a
variable that will hold either the submit button was pressed or not:

```
const isValidationPerformed = shallowRef(false)
```

Then, we create a computed variable that returns the list of validation errors:

```
const errors = computed(() => {
    if (!isValidationPerformed.value) {
      return undefined;
    }

    const validationResult = personalSchema.safeParse(formData)
    return validationResult.success ? undefined : validationResult.error.format()

})
```

A few more notes:

-   We use `safeParse` because we don't want to throw errors
-   We use [`error.format()`](https://zod.dev/?id=error-formatting) to format our
    errors into a convenient form. This method returns an object with messages
    in this kind of format:

    ```
    {
    	username: {
    		_errors: ["Required field"]
    	},
    	email: {
    		_errors: ["Invalid email"]
    	}
    	city: {
    		_errors: ["Required field"]
    	},

    }
    ```

Inside `onSubmit` function we set `isValidationPerformed` to `true`:

```
isValidationPerformed.value = true;
```

And finally, we need to display our error messages.
We always display only first error message from the list:

```
<div class="input">
    <label for="username"> Username </label>
    <input name="username" v-model="formData.username"/>
    <div class="error"> {{errors?.username?._errors[0]}} </div>
</div>
```

We use [optional chaining](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Optional_chaining), because we don't know if the specified
field exists in the `errors` object.

### How it works

1. By default, `isValidationPerformed` is set to `false`. User can
   edit any field, and no error messages will be shown.
2. When a user clicks the "Submit" button, we set `isValidationPerformed`
   variable to `true`.
3. `isValidationPerformed` is a reactive dependency in the `errors` computed,
   so it's recalculated when `isValidationPerformed` has changed.
4. If `errors` has any errors, they're shown under the input fields.
5. Since `isValidationPerformed` is true, any changes in the `formData`
   object also trigger `errors` computed recalculation, so when a user
   fixes an input value, the corresponding error message is disappeared
   (again, because of `error`'s recalculation)

### Dealing with empty strings

If we press the "Submit" button when the form is empty,
the "Required" error will be shown under our fields:

![Form screenshot](/img/vue-zod-4.png)

When we type something in, for example, the "username" field,
the error under the input field is disappeared:

![Form screenshot](/img/vue-zod-5.png)

But if we clear the field, no any error message will be shown:

![Form screenshot](/img/vue-zod-6.png)

That's because now our `formData.username` contains an
_empty string_, not an _undefined_ value, and this situation
fully satisfies the validation condition (it's a string and
its length don't overflow the limit). If we want
to forbid empty and space-only strings, we may use `trim()` and `min()`
combination:

```
// Create a separate zod schema for non-empty strings
const nonEmptyString = z.string().trim().min(1);

const personalSchema = z.object({
  username: nonEmptyString.max(50),
  email: nonEmptyString.email(),
  name: nonEmptyString.max(100),
  city: nonEmptyString.max(100),
  sameEmail: z.boolean(),
  workEmail: nonEmptyString.optional()
}).
refine((val) => {
  const emailRegex =
  /^([A-Z0-9_+-]+\.?)*[A-Z0-9_+-]@([A-Z0-9][A-Z0-9\-]*\.)+[A-Z]{2,}$/i;

  return val.sameEmail || emailRegex.test(val.workEmail)
}, {message: "Invalid email", path: ["workEmail"]})
```

Now everything works fine:

![Form validation screenshot](/img/vue-zod-7.png)

### The full code

```
<script setup lang="ts">
import {shallowReactive, shallowRef, computed} from "vue";
import {z} from "zod";

export interface PersonalInfo {
  username?: string;
  email?: string;
  name?: string;
  city?: string;
  workEmail?: string;

  /**
   * True if workEmail is the same as main email
   */
  sameEmail: boolean;
}

const nonEmptyString = z.string().trim().min(1);

const personalSchema = z.object({
  username: nonEmptyString.max(50),
  email: nonEmptyString.email(),
  name: nonEmptyString.max(100),
  city: nonEmptyString.max(100),
  sameEmail: z.boolean(),
  workEmail: nonEmptyString.optional()
}).
refine((val) => {
  const emailRegex =
  /^([A-Z0-9_+-]+\.?)*[A-Z0-9_+-]@([A-Z0-9][A-Z0-9\-]*\.)+[A-Z]{2,}$/i;

  return val.sameEmail || (val.workEmail ? emailRegex.test(val.workEmail) : false)
}, {message: "Invalid email", path: ["workEmail"]})

const isValidationPerformed = shallowRef(false)


const formData = shallowReactive<PersonalInfo>({
  sameEmail: true
})


const errors = computed(() => {
    if (!isValidationPerformed.value) {
      return undefined;
    }

    const validationResult = personalSchema.safeParse(formData)

    return validationResult.success ? undefined : validationResult.error.format()

})


function onSubmit() {
  isValidationPerformed.value = true;

  if (!errors.value) {
    alert(JSON.stringify(formData, null, 2));
    alert("All good!")
  } else {
    alert(JSON.stringify(errors.value, null, 2))
  }
}

</script>

<template>
<div class="container">
  <h1>Personal info</h1>
    <div class="input">
      <label for="username"> Username </label>
      <input name="username" v-model="formData.username"/>
      <div class="error"> {{errors?.username?._errors[0]}} </div>
    </div>
    <div class="input" >
      <label for="email"> Email </label>
      <input name="email" v-model="formData.email"/>
      <div class="error">  {{errors?.email?._errors[0]}} </div>
    </div>
    <div class="input">
      <label for="name"> Real name </label>
      <input name="name" v-model="formData.name"/>
      <div class="error">  {{errors?.name?._errors[0]}} </div>
    </div>
    <div class="input">
      <label for="city"> City  </label>
      <input name="city" v-model="formData.city"/>
      <div class="error">  {{errors?.city?._errors[0]}} </div>
    </div>
    <div>
      <label for="sameEmail"> Work email is the same as the main  </label>
      <input type="checkbox" name="sameEmail" v-model="formData.sameEmail" />
    </div>
    <div v-if="!formData.sameEmail" class="input">
      <label for="workemail"> Work email  </label>
      <input name="workemail" v-model="formData.workEmail"/>
      <div class="error">  {{errors?.workEmail?._errors[0]}} </div>
    </div>

    <button @click="onSubmit"> Submit </button>
  </div>
</template>

<style scoped>
.input {
display: flex;
  gap: 0.3rem;
  flex-direction: column;
}
.container {
  display: flex;
  gap: 1rem;
  flex-direction: column;
}

button {
  font-size: 1.5rem;
  margin-top: 1.5rem;
  background-color: blue;
}

.error {
  margin-top: -0.5rem;
  color: red;
  font-size: 0.5rem;
}
</style>
```

## Additional information and similar libraries

### Schema type inference

In our example, we declared our form interface first,
but it's also possible to infer the whole type from a
zod schema:

```
type PersonalInfo = z.infer<typeof personalSchema>;
```

### Similar libraries

There're also:

-   [Vee validate](https://vee-validate.logaretm.com/v4/). Probably the most popular validation solution for Vue.
    I personally don't like it much, yet it doesn't cancel the fact that
    this is a great library.
-   [Vuelidate](https://vuelidate-next.netlify.app/). Vue framework that validates data. Generally, it has the same
    concept as in our implementation.
-   [Yup](https://github.com/jquense/yup). For me, one of the benefits of `yup` over `zod` is the `when()` method,
    with which you can create conditional validation. By the way, `vee-validate`
    uses `yup` by default as a validation engine.
