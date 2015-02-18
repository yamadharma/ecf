# Running emacs as a daemon with systemd #

From [Running emacs as a daemon with systemd](http://blog.refu.co/?p=1296)

## Step 1. Create the systemd service ##

First of all we need to create the systemd service file as is shown in
the emacs wiki. Place the following into a file named
`/etc/systemd/system/emacs@.service`

	[Unit]
	Description=Emacs: the extensible, self-documenting text editor

	[Service]
	Type=forking
	ExecStart=/usr/bin/emacs --daemon
	ExecStop=/usr/bin/emacsclient --eval "(progn (setq kill-emacs-hook 'nil) (kill-emacs))"
	Restart=always
	User=%i
	WorkingDirectory=%h

	[Install]
	WantedBy=multi-user.target

The above should start your emacs in daemon mode at startup and
restart it even if it’s killed. It will start by the user who
enables/starts this service file and use his init file for startup.

To stop the emacs unit we use the emacsclient to send some lisp code
for evaluation. This code simply exits the process and stops the
daemon.

	(progn (setq kill-emacs-hook 'nil) (kill-emacs))

## Step 2. Enable the service ##

With systemd you can among other things, enable, disable, start, stop
or query a status of a service. We achieve all these by the following
commands for emacs as a service.

	~$ sudo systemctl enable emacs@lefteris.service
	~$ sudo systemctl disable emacs@lefteris.service
	~$ sudo systemctl start emacs@lefteris.service
	~$ sudo systemctl stop emacs@lefteris.service

	~$ systemctl status emacs@lefteris.service

Please note that you should replace lefteris with your own user
name. Also `.service` can be ommited. It simply serves to determine the
type of systemd unit we are referring to. Service is the
default. Other units can be mountpoints, devices and sockets.

    enable: The service will start from statup next time you boot the system
    disable: Undo an enable
    start: Starts the unit using the execution start command
    start: Stops the unit using the execution stop command
    status: Returns a status report about the unit

I would suggest you enable the emacs systemd unit now using the above
command. Then start it. You can also check the status of the unit and
get output similar to the one below.

	systemctl status emacs.service

## Step 3. Connect to the server using emacsclient ##

Now it should be pretty straight forward to connect to the running
emacs daemon using emacsclient. For example running emacsclient -c
should connect you to the server.

	emacsclient: connect: Connection refused
	emacsclient: No socket or alternate editor.  Please use:

        --socket-name
        --server-file      (or environment variable EMACS_SERVER_FILE)
        --alternate-editor (or environment variable ALTERNATE_EDITOR)

Wow! What’s this? But the server is indeed running. You can quickly
check it with a ps aux | grep emacs . And to add to that the owner of
the process is our user and not the root user. So what is the problem?

We should also check if the server is indeed listening and on which
socket by using the following command:

	~$ sudo netstat -xaupen | grep emacs

	unix  2      [ ACC ]     STREAM     LISTENING     88697    5924/emacs           /tmp/emacs1000/server

Hmm … the output looks all right but there is something weird about
the socket. Usually sockets opened by user programs should be under
/tmp/USERNAME/... . That explains why emacsclient can’t connect. So
all we have to do is alter the command a bit:

	emacsclient -c --socket-name /tmp/emacs1000/server

And voila! This connects us to the correct emacs server instance.

I can’t say I am sure if this can be considered a bug of emacsclient,
a bug of emacs in daemon mode or neither. In any case using the
`--socket-name` argument solves the problem and allows us to connect to
emacs at any point in time having it started as a systemd unit at
startup. If you have any comments or suggestions, especially
concerning the socket argument please don’t hesitate to write below.

## Configuring Emacs as a user systemd service ##

After working for some time with Emacs as a systemd service and
learning more about systemd I realized that there is a better (and
easier) way to configure emacs as a systemd service specified only for
the user you need. Accomplishing this is really easy. Look at the
following service file.

	[Unit]
	Description=Emacs: the extensible, self-documenting text editor

	[Service]
	Type=forking
	ExecStart=/usr/bin/emacs --daemon
	ExecStop=/usr/bin/emacsclient --eval "(progn (setq kill-emacs-hook 'nil) (kill-emacs))"
	Restart=always

    # Remove the limit in startup timeout, since emacs
    # cloning and building all packages can take time
	TimeoutStartSec=0

	[Install]
	WantedBy=default.target

The service file is almost the same as the one in the original post
except for the fact that User and Working directory do not need to be
specified. Moreover I have added TimeoutStartSec=0 to avoid systemd
killing emacs if for some reason it takes too long to start and send
the sd_notify message. This can happen if for example you are using
el-get to clone and build all your Emacs packages in a clean
environment.

Finally notice that multi-user target has been replaced by the
default.target. If you are using some other –user systemd scripts you
can configure that section properly. If you don’t know what a target
is then just leave it as the default.target. In –user service files
there is no multi-user.target so this is a field that you will need to
change.

Now all that you need to do is copy this service file as emacs.service
to `~/.config/systemd/user/emacs.service`. After that you can work with
it just as you did in the original blog post but with the main
difference of having to add the `--user` argument after `systemctl`. For
example:

	systemctl --user enable emacs
	systemctl --user start emacs
	systemctl --user stop emacs
	systemctl --user disable emacs

