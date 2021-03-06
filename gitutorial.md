# gitutorial

Trying to come to grips with Git, Github, EGit and StatET.

After installing the last version of Eclipse ('Neon Release (4.6.0)'), wanted to start using git and Github for real. I used git before - in several different context, but always from the command line, never from within Eclipse. In previous versions of Eclipse (used 3.8 for a long time), I never managed to get it to work properly. Decided to bite the bullet now.

Eclipse package 'EGit' integrates Git within Eclipse. EGit is installed by default together with Eclipse Neon, so no need for separate installs.

There is a useful short tutorial on Git available <a href='https://git-scm.com/docs/gittutorial' target='_blank'>here</a> or <a href='https://try.github.io/levels/1/challenges/1' target='_blank'>here</a>. Useful to familiarise with basic git operations. Both use CLI.

I started following the EGit tutorial available on <a href='http://eclipsesource.com/blogs/tutorials/egit-tutorial/' target='_blank'>http://eclipsesource.com/blogs/tutorials/egit-tutorial/</a>. Up to their section 9 ('Revert via Reset'), everything is nice and dandy, no problems, works as advertised. when following these sections, you create a local repository, bringing all the functionality of Git - it's possible to commit, write commit messages, create branches (though that's not covered in this part of the tutorial), and revert changes to any point in your history<sup id="a1"><a href="#f1">1</a></sup>. 

But then section 10, 'Cloning Repositories', comes a bit as a surprise - I was expecting instruction on how to push the test repository to github; instead the authors explain how to create a fresh repository on github, and how to download that to a local repository. Followed section 10 of the tutorial, downloading one of my existing projects (the <a href='https://github.com/evberghe/harmonograph' target='_blank'>harmonograph</a>) to a local repository. I downloaded to a directory that was a subdirectory of an existing project. Worked, but apparently Eclipse doesn't recognise the newly created directory as a repository directory in the project browser- there are no repository 'decorations' on the icons of the directory or its contents; and right-clicking doesn't give me the right context menu. Everything is fine, however, in the 'Git Repositories' window.

To upload a local repository to Github: first create a repository with the same name as the local one on Github. Place the URL of the newly created github repository on the clipboard. Then in Eclipse, right-click the repository directory, go to team > push in the context menu, and enter the URL when prompted.

Creating branches works as advertised. When checking out a branch, content created in another branch is not visible; edits done in another branch are equally invisible. Seems to make a lot of sense. Still do do some edits that require more sophisticated merging of branches - only done edits so far that could be merged automatically (and I assume that this would be the best way to work: make sure there is always only one person working on a branch/file.)

Mylyn is a task manager, installed by default together with Eclipse. There is a tutorial on its use on the <a href='http://wiki.eclipse.org/EGit/GitHub/User_Guide' target='_blank'>Eclipse website</a> - but doesn't corespond with my eclipse installation. According to the tutorial, 'Github tasks repositories' should be available under 'file > import...' but it isn't.
 


## notes

<b id="f1">1</b> For non-eclipse users: Eclipse also builds its own history file - it is always possible to compare recent versions of scripts with older versions, in a neat side-by-side view of old <i>vs</i> new, with plenty of tools to merge the content of the two versions. Git uses the same side-by-side views as core-Eclipse. Using Git, we basically have an unlimited history of our own edits, and can also compare our version of the scripts with edits done by others.<a href="#a1">↩</a>
