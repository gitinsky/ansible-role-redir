Eye.application 'redir-{{ name }}' do
  working_dir '/'
  stdall '/var/log/eye/redir-{{ name }}-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :redir_{{ name }} do
    pid_file '/var/run/redir-{{ name }}-eye.pid'
    start_command 'redir --laddr={{ from.ip | default('0.0.0.0') }} --lport={{ from.port }} --caddr={{ to.ip }} --cport={{ to.port }}'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
