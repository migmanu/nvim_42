## Using `neovim` at 42 School
![Screenshot from 2024-04-23 12-17-28](https://github.com/migmanu/42_docs/assets/52668755/b717e048-5377-433e-801e-5b69c71fabee)

Even though VS Code is available in campus, exams require you to use either plain old `vim` or `gedit`. So it is a good idea to get used to how `vim` works. It might take some time getting used to, but believe me, it is so worth it down the line.

For those of you who might still want a modern IDE experience, there tons of plugins and also `neovim` to help you get that.

### Installing `neovim`

This requires that you have `neovim` installed on your computer. If your campus does not provide you with it, you can do so without `sudo` privileges by using an AppImage, as detailed [here](https://github.com/neovim/neovim/blob/master/INSTALL.md):

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
mkdir -p /opt/nvim
mv nvim.appimage /opt/nvim/nvim
```

Add the path to your `~/.bashrc` or your `~/.zshrc`:

`export PATH="$PATH:/opt/nvim/"`

### Configuring `neovim`

By default, `neovim` will look for your configuration at `~/.config/nvim`.
 In here I provide my `neovim` configuration, which you can install running:

```bash
cd .config
git clone https://github.com/migmanu/nvim_42 nvim
```
Now run `nvim` and watch how `Lazy` installs the listed plugins.

My configuration uses [LazyVim](https://github.com/LazyVim/LazyVim) and is heavily based on the [starter template](http://www.lazyvim.org/installation).

In here you have more than you need to get started. Some of the helpful commands available are:

- `space` as leader key
- run `:Stdheader` to get 42 header on file
- `f2` for norminette formatting
- `Control + 7` toggle terminal
- `leader + e` to open files menu
- `leader ff` for file search
- `leader + sg` search by grep

One of the best quality of life plugins installed is [harpoon](https://github.com/ThePrimeagen/harpoon). I strongly recommend you taking a look at it. Between that and file search, you might never open the file explorer again!

*Note that this config is a work in progress and that it might still change a bunch.
