# Markdown to PDF - A style guide

Hello!  
This is a small documentation of issues and fixes I have found regarding the conversion from our Markdown-files into a single PDF. It contains all the issues I have encountered, as well as the ways to work around or fix them. I hope this will be helpful for everyone who intends to write articles for this project.

## How to use the script
You will need to have pandoc and LaTeX installed. You will also need to be able to run a Bash-Script.
You can simply start the script from its directory, it should do the rest. It will put the generated file in the same folder as the script (/scripts/pdf).

## Level 4+ header are not working properly
I have noticed that when we're using Level 4 or higher headers, linebreaks don't seem to work properly after the header. Text following the header gets put on the same line as the header.

### Workaround
I have worked around this, by simply replacing all Level-4+ headers with bold text.
It shows up exactly the same in the PDF, and since we don't add Level4+ headers to the Table of Contents anyway, we don't lose them there. 

## Linebreaks made with backslash ( '\\' ) don't work
Simple linebreaks made with a backslash are disregarded during the conversion-process, leading to text being put on the same line.

### Fix
Instead of using a backslash, use 2 spaces. This works perfectly, and is also a more widely recognized standard for markdown linebreaks.

## Table-spacing is all wrong
Text in tables either overlaps or is spaced really awkwardly.

### Fix
In Markdown, between the table header and content, we place dashes ( '-' ) to denote the separation between these two parts of the table.

Importantly, the amount of dashes placed in a single column will denote, how much space that column will use percentualy, in relation to the total amount of dashes used.

For Example:

``````
| This will use 1/4th | This will use 3/4ths |
| - | --- |
|Content|Content|
``````

It may look ugly in textformat, but on Github and in the PDF it will look just fine.

## Code-blocks that are very big shoot out of the page
If you have big Codeblocks in your Markdown, they will fly off the page in the PDF.

### Fix/Workaround
I sadly haven't found a good fix for this yet. To work around this, you'll have to break up your code manually.

