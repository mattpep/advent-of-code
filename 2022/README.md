# Goal(s) for this year

This year I have been attempting to gain a stronger understanding of Go. It
will be my primary language this year, but I'll likely need to make the
occasional fallback to Ruby.

I'll addtionally try to re-implment some of them in ansible, as a challenge to
(mis)use the tool!


# Progress

| Day | Go                             | Ansible           | Ruby              |
| --: | :-:                            | :-:               | :-:               |
| 1   | :1st_place_medal:              | :1st_place_medal: |                   |
| 2   | :1st_place_medal:              | :2nd_place_medal: |                   |
| 3   | :1st_place_medal:              |                   |                   |
| 4   | :1st_place_medal:              | :1st_place_medal: |                   |
| 5   | :2nd_place_medal:              |                   | :1st_place_medal: |
| 6   | :1st_place_medal: (plus tests) |                   |                   |
| 7   |                                |                   | :1st_place_medal: |
| 8   | :1st_place_medal: (plus tests) |                   |                   |
| 9   |                                |                   | :2nd_place_medal: |
| 10  |                                |                   | :1st_place_medal: |
| 11  |                                |                   | :1st_place_medal: |
| 12  |                                |                   |                   |
| 13  |                                |                   | :1st_place_medal: |

# Running the solutions

Replace `nn` with the day's number

## Ruby

Use nna.txt, nnb.txt etc for the smaller samples provided in a problem's description page

```
ruby nn.rb < data/nn.txt
```

## Go

```
go test nn*.go && go build nn.go && ./nn
```

## Ansible

```
ansible-playbook -i localhost, nn.yml
```
