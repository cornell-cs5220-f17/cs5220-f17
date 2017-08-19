---
title:      Submitting Homework with Git
layout:     main
---

We *strongly* encourage you to keep your code in a (private) hosted
Git repository.  This will help you avoid losing your work to
crashed drives and unruly pets, and will also make it easier to keep
code in sync between your laptop and the class cluster.  Possible
options include:

 - [Cornell's Github server](http://github.coecis.cornell.edu/)
 - [GitHub](https://github.com/)
 - [BitBucket](https://bitbucket.org/)
 - [GitLab](https://about.gitlab.com/)

We will use [CMS] to submit all class homeworks and projects this
semester.  However, for homeworks that include code, you may choose
to use [CMS] *either* to submit a tarball with the code files directly
*or* to submit a pointer to a Git repository that contains your
submission.  If you choose to do the latter, you should use the
following process to make sure that we are able to access the correct
version of your code:

1.  Create a `submission` tag and make sure it is synchronized with
    the origin:
    
        git tag submission
        git push origin --tags

    This marks the commit you want to tag as submission ready; we will 
    not consider any commits past the submission tag. 
    
2.  Add the [CS 5220 SSH key](cs5220.pub) as a "deployment key" or
    "access key" with
    permission to read the repository (read-only should be the default).  Directions for how to do this
    under
    [GitHub](https://developer.github.com/v3/guides/managing-deploy-keys/),
    [Bitbucket](https://confluence.atlassian.com/bitbucket/use-access-keys-294486051.html),
    and
    [GitLab](https://support.deployhq.com/articles/repositories/adding-a-new-deployment-key-to-gitlab)
    are available online.
    
    Adding this key will give us read access, thereby allowing us to properly look at your repository. 
    No key means no access on our side! 

3.  In CMS, fill out the `repo.txt` file with the SSH link to the
    repository, e.g.
    
        git@github.coecis.cornell.edu:dsb253/test_repository.git

    The `repo.txt` file should contain *only* the name of the
    repository where you keep your code, and that code *must* provide
    access to the CS 5220 SSH key -- otherwise we cannot read your
    code for grading!  Make sure to get the SSH link and not the 
    HTTPS link.  

If you would like the professor or the TA to be able to comment on
your code independent of the submission process, you can always add us
to your repository as regular collaborators with read-only access.  We
are `dsb253` and `ehl59` on the Cornell GitHub, and `dbindel` and
`ericlee0803` on GitHub and Bitbucket (and GitLab in the case of the
professor).

[CMS]: http://cms.csuglab.cornell.edu/web/guest/
