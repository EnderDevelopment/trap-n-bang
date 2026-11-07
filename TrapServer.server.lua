local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local trap = workspace:WaitForChild("Trap")
assert(trap:IsA("BasePart"), "Workspace.Trap must be a BasePart")

local CAPTURE_SECONDS = 2
local COOLDOWN_SECONDS = 4
local BANG_RADIUS = 12
local BANG_DAMAGE = 25
local activeCharacters = {}
local trapReady = true

local function makeBang(position)
	local explosion = Instance.new("Explosion")
	explosion.Position = position
	explosion.BlastRadius = BANG_RADIUS
	explosion.BlastPressure = 0
	explosion.DestroyJointRadiusPercent = 0
	explosion.ExplosionType = Enum.ExplosionType.NoCraters
	explosion.Parent = workspace
	Debris:AddItem(explosion, 2)

	for _, player in Players:GetPlayers() do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if humanoid and root and humanoid.Health > 0 and (root.Position - position).Magnitude <= BANG_RADIUS then
			humanoid:TakeDamage(BANG_DAMAGE)
		end
	end
end

local function triggerTrap(hit)
	if not trapReady then
		return
	end

	local character = hit:FindFirstAncestorOfClass("Model")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root or humanoid.Health <= 0 or activeCharacters[character] then
		return
	end

	trapReady = false
	activeCharacters[character] = true

	local oldWalkSpeed = humanoid.WalkSpeed
	local oldJumpPower = humanoid.JumpPower
	local oldJumpHeight = humanoid.JumpHeight
	local oldAutoRotate = humanoid.AutoRotate

	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.JumpHeight = 0
	humanoid.AutoRotate = false
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero

	task.wait(CAPTURE_SECONDS)
	if humanoid.Parent and humanoid.Health > 0 then
		local bangPosition = root.Position
		humanoid.WalkSpeed = oldWalkSpeed
		humanoid.JumpPower = oldJumpPower
		humanoid.JumpHeight = oldJumpHeight
		humanoid.AutoRotate = oldAutoRotate
		makeBang(bangPosition)
	end

	activeCharacters[character] = nil
	task.wait(COOLDOWN_SECONDS)
	trapReady = true
end

trap.Touched:Connect(triggerTrap)
