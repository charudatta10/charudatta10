from invoke import task, Collection, Context

@task
def commit(ctx, message="init"):
    ctx.run("git add .")
    ctx.run(f"git commit -m \"{message}\"")

@task
def quit(ctx):
    print("Copyright © 2024 Charudatta")

@task
def cv(ctx):
    with ctx.cd("src/cv"):
        ctx.run("lualatex cv.tex")

@task
def portfolio(ctx):
    with ctx.cd("src/portfolio"):
        ctx.run("marp portfolio.md")
        ctx.run("marp --pdf portfolio.md --pdf-notes --pdf-outlines --allow-local-files")
        ctx.run("marp --pptx portfolio.md --allow-local-files")

@task
def resume(ctx):
    with ctx.cd("src/resume"):
        ctx.run("pandoc resume.md -f markdown -t html -c resume.css -s -o resume.html")
        ctx.run("wkhtmltopdf --enable-local-file-access resume.html resume.pdf")

@task(default=True)
def default(ctx):
    # Get a list of tasks
    tasks = sorted(ns.tasks.keys())
    # Display tasks and prompt user
    for i, task_name in enumerate(tasks, 1):
        print(f"{i}: {task_name}")
    choice = int(input("Enter the number of your choice: "))
    ctx.run(f"invoke {tasks[choice - 1]}")

# Create a collection of tasks
ns = Collection(update_progress, commit, quit, run_backup, list_pipx_installed_packages, list_scoop_installed_apps, default)
