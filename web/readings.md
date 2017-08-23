---
title: Readings
layout: main
---

As an organizational note: none of us have enough hours in a day,
and you probably won't read most of the references below.  In order
to help sort out the ones I most recommend, I split each subsection
into a main recommendation and other recommendations, and deliberately
stick to one main recommendation.

This page is a living document.  If there are good sources you think
I've missed, please do submit a pull request against the main
repository.

## Recommended texts

There is no required class for the text, and I will teach primarily
from my own notes and slide decks, as well as from papers.
Nonetheless, it's good to have a reference or two.

### Main recommendation

- [Introduction to High Performance Computing for Scientists and Engineers (Hager and Wellein)][hager-book]

[hager-book]: http://www.amazon.com/Introduction-Performance-Computing-Scientists-Computational/dp/143981192X

### Other recommendations

- [Structured Parallel Programming (McCool, Reinders, Robison)][mccool-book]
- [Programming Massively Parallel Processors (Kirk and Hwu)][kirk-book]
- [Performance Optimization of Numerically Intensive Codes (Goedecker)][goedecker-book]
- [Principles of Parallel Programming (Lin and Snyder)][lin-book]
- [Introduction to Parallel Programming (Pacheco)][pacheco-book]
- [Parallel Programming (Wilkinson and Allen)][wilkinson-book]

[mccool-book]: http://www.amazon.com/Structured-Parallel-Programming-Efficient-Computation/dp/0124159931
[kirk-book]: http://www.amazon.com/Programming-Massively-Parallel-Processors-Second/dp/0124159923/
[goedecker-book]: http://epubs.siam.org/doi/book/10.1137/1.9780898718218
[lin-book]: http://www.amazon.com/Principles-Parallel-Programming-Calvin-Lin/dp/0321487907
[pacheco-book]: http://www.amazon.com/Introduction-Parallel-Programming-Peter-Pacheco/dp/0123742609
[wilkinson-book]: http://www.amazon.com/Parallel-Programming-Techniques-Applications-Workstations/dp/0131405632

## Related course materials

### Main recommendation

The closest course to CS 5220 (apart from previous instances of the
class) is Jim Demmel's Applications of Computers (Berkeley
CS 267), [available here][cs267] in online form.

[cs267]: https://cvw.cac.cornell.edu/APC/

### Other recommendations

- Alan Edelman at MIT teaches a different parallel programming course,
  with the most recent iterations based on [Julia][julia].  Materials
  are [available here on MIT OpenCourseWare][mit-ocw-julia]].
- Georgia Tech has two HPC courses; CSE 6220 and [CSE 6230][cse6230].
  Without exploring in detail, I think we're closer to the latter.
- Randy Leveque at UW has also been experimenting with a flipped
  classroom for their intro HPC class, [AM583][am583].  You may also
  be interested in the [MOOC version][am583-mooc].

[julia]: http://julialang.org/
[mit-ocw-julia]: http://ocw.mit.edu/courses/mathematics/18-337j-parallel-computing-fall-2011/
[cse6230]: http://vuduc.org/cse6230/
[am583]: http://faculty.washington.edu/rjl/classes/am583s2014/
[am583-mooc]: https://www.coursera.org/course/scicomp

## Related resources from Intel

Intel has supported our course through a generous hardware donation.
Part of the point is to develop new curricular content on parallel
programming.  They also have lots of existing curricular content and
tutorials and references on Intel parallel technology, and these
are worth a browse.

- [Intel code modernization site][modern-code]
- [Intel MIC developer site][mic-developer]
- [Video lectures on parallel computing][intel-university]
- [Parallel programming curriculum initiative][pp-initiative]
- [Parallel programming curriculum content][pp-curricula]

[modern-code]: https://software.intel.com/en-us/modern-code
[mic-developer]: https://software.intel.com/en-us/mic-developer
[pp-initiative]: https://www-ssl.intel.com/content/www/us/en/education/university/parallel-programming-initiative.html
[pp-curricula]: http://www.intel.com/content/www/us/en/education/university/parallel-programming-initiative/curricula.html
[intel-university]: http://university.intel.com/

## Recommended software skills background

Though I expect students taking the class to have some programming
proficiency, that doesn't necessarily mean everyone will have seen
a Unix command line or a version control system.  I *mostly* won't
spend class time on this, so you should take some time to brush up
on your own.

### Main recommendation

[Software Carpentry][sw-carpentry] has good lessons on Unix shell
and Git.  If you're unfamiliar with `make`, the lesson on Automation
and Make may also be useful (though less immediately critical).

[sw-carpentry]: http://software-carpentry.org/lessons.html

### Other recommendations

- Cornell's Center for Advanced Computing (CAC) offers a number
  of online training modules, including a good
  [Linux introduction][cac-linux].
- [GitHub][github] has links to several good resources for
  [learning about Git and GitHub][github-learning].
  I was particularly amused by the interactive [Try Git][try-git]
  tutorial.
- Atlassian (makers of [BitBucket][bitbucket]) have a good
  [set of Git tutorials as well][bitbucket-turorials].
- [ProGit][progit] is a freely available online book that
  covers the basics and much more.

As an aside: [BitBucket][bitbucket] is probably the primary competitor to Git.
I recommend getting accounts on both GitHub and BitBucket;
the latter provides unlimited private repositories for educational
users, which is helpful for managing proposals, paper drafts, and
other projects that you might want to keep initially private.

[cac-linux]: https://cvw.cac.cornell.edu/Linux/
[github]: http://www.github.com/
[github-learning]: https://help.github.com/articles/good-resources-for-learning-git-and-github/
[try-git]: http://try.github.com/
[bitbucket]: http://bitbucket.org/
[bitbucket-tutorial]: https://www.atlassian.com/git/tutorials
[progit]: http://git-scm.com/doc

## C background

You *will* need to have prior programming experience in some C family
language (Java, C, C++, C#), but that doesn't mean you will have done
any C programming before.  We're going to use C as the lingua franca
for most of the class, so it's a good idea to do some reading if you
don't know the language already.

### Main reference

[The C Programming Language (Kernighan and Ritchie)][kr-book]
is the bible of C programming.  I like it both as a reference to
the language and an example of how to write an effective manual.

### Other references

- The [C intro from CAC][c-cac] is not a bad place to get started
  learning about C.  In particular, check out their
  [references page][cref-cac].
- Materials from an MIT course on [Practical Programming in C][mit-ocw-c]
  also look pretty good.
- Cornell offers courses in C (CS 2022) and C++ (CS 2024).

[kr-book]: https://www.amazon.com/exec/obidos/ASIN/0131103628/
[c-cac]: https://cvw.cac.cornell.edu/CIntro/
[cref-cac]: https://cvw.cac.cornell.edu/main/reference
[mit-ocw-c]: http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-087-practical-programming-in-c-january-iap-2010/lecture-notes/

Specifically, you will want to look at the lessons on the Unix shell
and Git early on, and the lesson on Automation and Make fairly soon.
For later in the class, you may want the lesson on Programming with
Python.

## Python background

Knowledge of Python is *not* strictly required for this class, but we
will use Python in some of our work.  We teach a Python course at
Cornell (CS 1110) as our introductory course, but you are *not* the
target audience for that class.

### Main reference

CAC has instructional modules on [Introduction to Python][cac-pyintro]
and [Python for HPC][cac-pyhpc] that fit well with the perspectives of
this course.

### Other references

- The [Software Carpentry lessons][sw-carpentry] include a good Python
  lesson that focuses on computational science uses.
- The official [Python documentation][pydocs] is not a bad place to
  start; see particularly the [tutorial][pytutorial] if you're new to
  the language.
- The [SciPy lecture notes][scipy-lectures] are a nice intro
  to the SciPy ecosystem.
- [Dive Into Python][divepy] is a nice introduction to Python for
  experienced programmers coming from other languages.
- My personal favorite Python text is probably
  [Python Essential Reference][beazley]
  by David Beazley.
- I believe CS 1110 at Cornell has used [Think Python][thinkpy]
  and [Thinking like a Computer Scientist][thinkcs] as texts
  in the recent past.

[cac-pyintro]: https://cvw.cac.cornell.edu/pythonintro/
[cac-pyhpc]: https://cvw.cac.cornell.edu/python/
[pydocs]: https://docs.python.org/3/
[pytutorial]: https://docs.python.org/3/tutorial/index.html
[scipy-lectures]: http://scipy-lectures.github.io/index.html
[thinkpy]: http://www.greenteapress.com/thinkpython/html
[thinkcs]: http://www.openbookproject.net/thinkcs/python/english3e
[divepy]: http://www.diveintopython.net/index.html
[beazley]: http://www.amazon.com/Python-Essential-Reference-4th-Edition/dp/0672329786
